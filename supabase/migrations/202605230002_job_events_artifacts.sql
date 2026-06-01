create table if not exists job_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  job_id uuid not null references processing_jobs(id) on delete cascade,
  event_type text not null,
  status text,
  progress int check (progress between 0 and 100),
  message text not null,
  payload jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index if not exists idx_job_events_job_created
on job_events(job_id, created_at);

create table if not exists processing_artifacts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  processing_job_id uuid references processing_jobs(id) on delete cascade,
  generated_short_id uuid references generated_shorts(id) on delete cascade,
  artifact_kind text not null,
  bucket text not null,
  object_key text not null,
  public_url text,
  byte_size bigint,
  content_type text,
  checksum_sha256 text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  unique (bucket, object_key)
);

create index if not exists idx_processing_artifacts_job
on processing_artifacts(processing_job_id);

create index if not exists idx_processing_artifacts_short
on processing_artifacts(generated_short_id);

alter table job_events enable row level security;
alter table processing_artifacts enable row level security;

drop policy if exists "job events own rows" on job_events;
create policy "job events own rows" on job_events for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

drop policy if exists "processing artifacts own rows" on processing_artifacts;
create policy "processing artifacts own rows" on processing_artifacts for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));
