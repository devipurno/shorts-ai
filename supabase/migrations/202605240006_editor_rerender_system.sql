-- Stage 5 editor and rerender persistence.
-- Safe to run on an existing Supabase project; it only creates missing structures/policies.

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

create index if not exists idx_review_actions_short_created on review_actions(generated_short_id, created_at desc);
create index if not exists idx_render_versions_short_version on render_versions(generated_short_id, version desc);

alter table review_actions enable row level security;
alter table render_versions enable row level security;

drop policy if exists "review actions own rows" on review_actions;
create policy "review actions own rows" on review_actions for all
using (user_id in (select id from users where supabase_user_id = auth.uid()))
with check (user_id in (select id from users where supabase_user_id = auth.uid()));

drop policy if exists "render versions own rows" on render_versions;
create policy "render versions own rows" on render_versions for all
using (
  generated_short_id in (
    select id
    from generated_shorts
    where user_id in (select id from users where supabase_user_id = auth.uid())
  )
)
with check (
  generated_short_id in (
    select id
    from generated_shorts
    where user_id in (select id from users where supabase_user_id = auth.uid())
  )
);
