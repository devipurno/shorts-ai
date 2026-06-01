-- Stage 4 review system support.
-- Keep the newer generated_clips review table available in every environment
-- and allow backend-generated shorts to be mirrored into it with matching IDs.

do $$
begin
  if exists (
    select 1
    from pg_class c
    join pg_namespace n on n.oid = c.relnamespace
    where n.nspname = 'public'
      and c.relname = 'generated_clips'
      and c.relkind = 'v'
  ) then
    drop view generated_clips;
  end if;
end $$;

create table if not exists generated_clips (
  id uuid primary key default gen_random_uuid(),
  processing_job_id uuid not null references processing_jobs(id) on delete cascade,
  clip_start numeric(10,3) not null,
  clip_end numeric(10,3) not null,
  clip_duration int not null,
  clip_title text not null,
  subtitle_path text,
  video_path text,
  thumbnail_path text,
  score int not null check (score between 0 and 100),
  created_at timestamptz not null default now()
);

alter table generated_clips
  add column if not exists status short_status not null default 'generated',
  add column if not exists description text not null default '',
  add column if not exists hashtags text[] not null default '{}',
  add column if not exists rerender_requested_at timestamptz,
  add column if not exists updated_at timestamptz not null default now();

create index if not exists idx_generated_clips_job_score on generated_clips(processing_job_id, score desc);
create index if not exists idx_generated_clips_status on generated_clips(status);
create index if not exists idx_generated_clips_updated_at on generated_clips(updated_at desc);

create or replace function touch_generated_clips_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trg_generated_clips_updated_at on generated_clips;
create trigger trg_generated_clips_updated_at
before update on generated_clips
for each row execute function touch_generated_clips_updated_at();

alter table generated_clips enable row level security;

drop policy if exists "generated clips own rows" on generated_clips;
create policy "generated clips own rows" on generated_clips for all
using (
  processing_job_id in (
    select id
    from processing_jobs
    where user_id in (select id from users where supabase_user_id = auth.uid())
  )
)
with check (
  processing_job_id in (
    select id
    from processing_jobs
    where user_id in (select id from users where supabase_user_id = auth.uid())
  )
);

do $$
begin
  alter publication supabase_realtime add table generated_clips;
exception when duplicate_object then null;
end $$;
