-- AutoShort project + source video system.
-- Backward-compatible with the existing ShortFlow schema.

create extension if not exists pgcrypto;

alter type source_type add value if not exists 'youtube';
alter type source_type add value if not exists 'upload';

alter table projects add column if not exists title text;
alter table projects add column if not exists description text not null default '';

update projects
set title = coalesce(title, name)
where title is null;

alter table projects alter column title set not null;

alter table source_videos add column if not exists youtube_url text;
alter table source_videos add column if not exists original_filename text;
alter table source_videos add column if not exists storage_path text;
alter table source_videos add column if not exists duration int;
alter table source_videos add column if not exists status text not null default 'saved';

update source_videos
set youtube_url = coalesce(youtube_url, source_url)
where youtube_url is null and source_url is not null;

update source_videos
set storage_path = coalesce(storage_path, original_file_url)
where storage_path is null and original_file_url is not null;

create index if not exists idx_projects_user_created_at on projects(user_id, created_at desc);
create index if not exists idx_source_videos_project_created_at on source_videos(project_id, created_at desc);
create index if not exists idx_source_videos_user_created_at on source_videos(user_id, created_at desc);

create or replace function set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_projects_updated_at on projects;
create trigger set_projects_updated_at
before update on projects
for each row execute function set_updated_at();

drop trigger if exists set_source_videos_updated_at on source_videos;
create trigger set_source_videos_updated_at
before update on source_videos
for each row execute function set_updated_at();

create or replace function ensure_current_user()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  current_auth_user uuid;
  current_email text;
  current_name text;
  app_user_id uuid;
begin
  current_auth_user := auth.uid();
  if current_auth_user is null then
    raise exception 'Authentication required';
  end if;

  current_email := coalesce(auth.jwt() ->> 'email', current_auth_user::text || '@autoshort.local');
  current_name := coalesce(
    auth.jwt() -> 'user_metadata' ->> 'full_name',
    auth.jwt() -> 'user_metadata' ->> 'name',
    current_email
  );

  select id into app_user_id
  from users
  where supabase_user_id = current_auth_user;

  if app_user_id is null then
    insert into users (id, supabase_user_id, email, display_name)
    values (gen_random_uuid(), current_auth_user, current_email, current_name)
    on conflict (email) do update
      set supabase_user_id = excluded.supabase_user_id,
          display_name = excluded.display_name,
          updated_at = now()
    returning id into app_user_id;
  end if;

  return app_user_id;
end;
$$;

grant execute on function ensure_current_user() to authenticated;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'uploads',
  'uploads',
  false,
  536870912,
  array['video/mp4','video/quicktime','video/webm','image/jpeg','image/png']
)
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "authenticated uploads read own objects" on storage.objects;
create policy "authenticated uploads read own objects" on storage.objects for select to authenticated
using (
  bucket_id = 'uploads'
  and split_part(name, '/', 1) in ('originals', 'renders', 'thumbnails')
  and split_part(name, '/', 2) = auth.uid()::text
);

drop policy if exists "authenticated uploads insert own objects" on storage.objects;
create policy "authenticated uploads insert own objects" on storage.objects for insert to authenticated
with check (
  bucket_id = 'uploads'
  and split_part(name, '/', 1) in ('originals', 'renders', 'thumbnails')
  and split_part(name, '/', 2) = auth.uid()::text
);

drop policy if exists "authenticated uploads update own objects" on storage.objects;
create policy "authenticated uploads update own objects" on storage.objects for update to authenticated
using (
  bucket_id = 'uploads'
  and split_part(name, '/', 1) in ('originals', 'renders', 'thumbnails')
  and split_part(name, '/', 2) = auth.uid()::text
)
with check (
  bucket_id = 'uploads'
  and split_part(name, '/', 1) in ('originals', 'renders', 'thumbnails')
  and split_part(name, '/', 2) = auth.uid()::text
);

do $$
begin
  alter publication supabase_realtime add table projects;
exception when duplicate_object then null;
end $$;

do $$
begin
  alter publication supabase_realtime add table source_videos;
exception when duplicate_object then null;
end $$;
