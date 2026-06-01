-- ShortFlow AI Supabase migration.
-- Canonical app schema is mirrored from infra/database/migrations/001_mvp_schema.sql.

create extension if not exists pgcrypto;

do $$ begin create type source_type as enum ('youtube_url','upload_file'); exception when duplicate_object then null; end $$;
do $$ begin create type processing_status as enum ('queued','downloading','transcribing','detecting_clips','rendering','generating_metadata','generating_thumbnails','completed','failed'); exception when duplicate_object then null; end $$;
do $$ begin create type short_status as enum ('generated','reviewed','queued','uploaded','rejected','failed'); exception when duplicate_object then null; end $$;
do $$ begin create type upload_status as enum ('queued','uploading','uploaded','failed','cancelled'); exception when duplicate_object then null; end $$;
do $$ begin create type privacy_status as enum ('private','unlisted','public'); exception when duplicate_object then null; end $$;
do $$ begin create type notification_type as enum ('processing_completed','processing_failed','upload_completed','upload_failed'); exception when duplicate_object then null; end $$;

create table if not exists users (
  id uuid primary key,
  supabase_user_id uuid unique,
  email text not null unique,
  display_name text not null,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  name text not null,
  default_language text not null default 'id',
  max_shorts_per_video int not null default 5 check (max_shorts_per_video between 1 and 10),
  target_duration_min int not null default 20,
  target_duration_max int not null default 60,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists source_videos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  project_id uuid not null references projects(id) on delete cascade,
  source_type source_type not null,
  source_url text,
  original_file_url text,
  title text not null,
  duration_seconds int,
  thumbnail_url text,
  metadata jsonb not null default '{}'::jsonb,
  uploaded_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists idx_source_videos_unique_url_per_project
on source_videos(project_id, source_url)
where source_url is not null;

create table if not exists processing_jobs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  project_id uuid not null references projects(id) on delete cascade,
  source_video_id uuid not null references source_videos(id) on delete cascade,
  status processing_status not null default 'queued',
  progress int not null default 0 check (progress between 0 and 100),
  current_step text not null default 'Waiting for worker',
  error_message text,
  last_error_code text,
  attempts int not null default 0,
  locked_at timestamptz,
  started_at timestamptz,
  completed_at timestamptz,
  failed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists generated_shorts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  project_id uuid not null references projects(id) on delete cascade,
  source_video_id uuid not null references source_videos(id) on delete cascade,
  processing_job_id uuid not null references processing_jobs(id) on delete cascade,
  title_suggestion text not null,
  start_time numeric(10,3) not null,
  end_time numeric(10,3) not null,
  duration_seconds int not null,
  score int not null check (score between 0 and 100),
  score_reason text not null,
  hook_text text not null,
  status short_status not null default 'generated',
  preview_url text not null,
  video_url text not null,
  selected_thumbnail_id uuid,
  hashtags text[] not null default '{}',
  description text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (processing_job_id, start_time, end_time)
);

create or replace view generated_clips as select * from generated_shorts;

create table if not exists subtitle_tracks (
  id uuid primary key default gen_random_uuid(),
  generated_short_id uuid not null references generated_shorts(id) on delete cascade,
  language text not null default 'id',
  srt_url text,
  vtt_url text,
  transcript_json jsonb not null default '[]'::jsonb,
  style jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (generated_short_id, language)
);

create table if not exists thumbnail_options (
  id uuid primary key default gen_random_uuid(),
  generated_short_id uuid not null references generated_shorts(id) on delete cascade,
  image_url text not null,
  score int check (score between 0 and 100),
  is_selected boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists short_metadata (
  id uuid primary key default gen_random_uuid(),
  generated_short_id uuid not null unique references generated_shorts(id) on delete cascade,
  title text not null,
  description text not null,
  hashtags text[] not null default '{}',
  ai_reasoning jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists review_actions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  generated_short_id uuid not null references generated_shorts(id) on delete cascade,
  action text not null check (action in ('queued','rejected','edited')),
  payload jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists render_versions (
  id uuid primary key default gen_random_uuid(),
  generated_short_id uuid not null references generated_shorts(id) on delete cascade,
  version int not null,
  video_url text,
  subtitle_style jsonb not null default '{}'::jsonb,
  status processing_status not null default 'queued',
  created_at timestamptz not null default now(),
  unique (generated_short_id, version)
);

create table if not exists social_accounts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  provider text not null check (provider = 'youtube'),
  provider_account_id text not null,
  channel_name text not null,
  avatar_url text,
  encrypted_refresh_token text,
  scopes text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, provider, provider_account_id)
);

create table if not exists upload_queue (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  generated_short_id uuid not null references generated_shorts(id) on delete cascade,
  social_account_id uuid references social_accounts(id) on delete set null,
  privacy_status privacy_status not null default 'private',
  status upload_status not null default 'queued',
  progress int not null default 0 check (progress between 0 and 100),
  youtube_video_id text,
  error_message text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  uploaded_at timestamptz,
  unique (generated_short_id)
);

create table if not exists upload_attempts (
  id uuid primary key default gen_random_uuid(),
  upload_queue_id uuid not null references upload_queue(id) on delete cascade,
  attempt_number int not null,
  status upload_status not null,
  error_code text,
  error_message text,
  provider_response jsonb not null default '{}'::jsonb,
  started_at timestamptz not null default now(),
  finished_at timestamptz
);

create table if not exists device_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  token text not null,
  platform text not null check (platform in ('ios','android','web')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, token)
);

create table if not exists notification_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  type notification_type not null,
  title text not null,
  body text not null,
  payload jsonb not null default '{}'::jsonb,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('shortflow-videos', 'shortflow-videos', false, 2147483648, array['video/mp4','video/quicktime','image/jpeg','image/png','text/plain','text/vtt','application/json'])
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

alter publication supabase_realtime add table processing_jobs;
alter publication supabase_realtime add table generated_shorts;
alter publication supabase_realtime add table upload_queue;
alter publication supabase_realtime add table notification_events;

alter table users enable row level security;
alter table projects enable row level security;
alter table source_videos enable row level security;
alter table processing_jobs enable row level security;
alter table generated_shorts enable row level security;
alter table upload_queue enable row level security;
alter table notification_events enable row level security;
alter table review_actions enable row level security;
alter table render_versions enable row level security;

create policy "users own row" on users for all
using (supabase_user_id = auth.uid()) with check (supabase_user_id = auth.uid());

create policy "projects own rows" on projects for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

create policy "source videos own rows" on source_videos for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

create policy "processing jobs own rows" on processing_jobs for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

create policy "generated shorts own rows" on generated_shorts for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

create policy "upload queue own rows" on upload_queue for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

create policy "notification events own rows" on notification_events for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

create policy "review actions own rows" on review_actions for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

create policy "render versions own rows" on render_versions for all
using (generated_short_id in (
  select id from generated_shorts where user_id in (select id from users where supabase_user_id = auth.uid())
))
with check (generated_short_id in (
  select id from generated_shorts where user_id in (select id from users where supabase_user_id = auth.uid())
));

create policy "authenticated storage read own objects" on storage.objects for select to authenticated
using (bucket_id = 'shortflow-videos' and split_part(name, '/', 2) = auth.uid()::text);

create policy "authenticated storage insert own objects" on storage.objects for insert to authenticated
with check (bucket_id = 'shortflow-videos' and split_part(name, '/', 2) = auth.uid()::text);

create policy "authenticated storage update own objects" on storage.objects for update to authenticated
using (bucket_id = 'shortflow-videos' and split_part(name, '/', 2) = auth.uid()::text)
with check (bucket_id = 'shortflow-videos' and split_part(name, '/', 2) = auth.uid()::text);
