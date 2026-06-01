-- Bridge the generated_clips pipeline table to the mobile Review, Editor,
-- and Queue tabs without depending on the old Fastify demo API.

alter table generated_clips
  add column if not exists status short_status not null default 'generated',
  add column if not exists description text not null default '',
  add column if not exists hashtags text[] not null default '{}',
  add column if not exists rerender_requested_at timestamptz,
  add column if not exists updated_at timestamptz not null default now();

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
