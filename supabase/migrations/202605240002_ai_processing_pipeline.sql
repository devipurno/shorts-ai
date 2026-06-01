-- AutoShort AI processing pipeline.
-- Adds the MVP pipeline states requested by the mobile UX while keeping the
-- earlier backend statuses available for existing Fastify/worker code.

alter type processing_status add value if not exists 'analyzing';
alter type processing_status add value if not exists 'detecting_hooks';
alter type processing_status add value if not exists 'generating_subtitles';
alter type processing_status add value if not exists 'rendering_clips';

alter table processing_jobs add column if not exists current_stage text not null default 'queued';

update processing_jobs
set current_stage = status::text
where current_stage is null or current_stage = 'queued';

create index if not exists idx_processing_jobs_user_created_at on processing_jobs(user_id, created_at desc);
create index if not exists idx_processing_jobs_project_created_at on processing_jobs(project_id, created_at desc);
create index if not exists idx_processing_jobs_status on processing_jobs(status);

drop view if exists generated_clips;

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

create index if not exists idx_generated_clips_job_score on generated_clips(processing_job_id, score desc);

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

create or replace function create_processing_job_for_source(input_source_video_id uuid)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  app_user_id uuid;
  source_row source_videos%rowtype;
  existing_job_id uuid;
  created_job_id uuid;
begin
  app_user_id := ensure_current_user();

  select *
  into source_row
  from source_videos
  where id = input_source_video_id
    and user_id = app_user_id;

  if source_row.id is null then
    raise exception 'Source video not found or not owned by current user';
  end if;

  select id
  into existing_job_id
  from processing_jobs
  where source_video_id = input_source_video_id
    and user_id = app_user_id
    and status <> 'failed'
  order by created_at desc
  limit 1;

  if existing_job_id is not null then
    return existing_job_id;
  end if;

  insert into processing_jobs (
    user_id,
    project_id,
    source_video_id,
    status,
    progress,
    current_stage,
    current_step
  )
  values (
    app_user_id,
    source_row.project_id,
    source_row.id,
    'queued',
    0,
    'queued',
    'Queued for AI processing'
  )
  returning id into created_job_id;

  insert into job_events (user_id, job_id, event_type, status, progress, message, payload)
  values (
    app_user_id,
    created_job_id,
    'created',
    'queued',
    0,
    'Processing job created from source video',
    jsonb_build_object(
      'source_video_id', source_row.id,
      'project_id', source_row.project_id,
      'source_type', source_row.source_type::text,
      'n8n_webhook', 'process-source-video'
    )
  );

  return created_job_id;
end;
$$;

grant execute on function create_processing_job_for_source(uuid) to authenticated;

do $$
begin
  alter publication supabase_realtime add table generated_clips;
exception when duplicate_object then null;
end $$;
