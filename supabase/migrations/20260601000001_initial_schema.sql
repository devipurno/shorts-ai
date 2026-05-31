-- AutoShort mobile app schema.
-- Safe to run after existing MVP backend migrations: every object is guarded.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null default '',
  name text not null default '',
  bio text not null default '',
  avatar_url text,
  phone_number text,
  locale text not null default 'id_ID',
  timezone text not null default 'Asia/Bangkok',
  instagram_handle text,
  youtube_handle text,
  tiktok_handle text,
  niche text not null default 'other',
  target_audience text not null default '',
  content_language text not null default 'id',
  tier text not null default 'free',
  subscription_id uuid,
  subscription_expires_at timestamptz,
  trial_started_at timestamptz,
  trial_ends_at timestamptz,
  trial_days_remaining integer not null default 0,
  referral_code text,
  referred_by_user_id uuid references public.profiles(id) on delete set null,
  brand_kit_id uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  last_login_at timestamptz
);

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  description text not null default '',
  status text not null default 'draft',
  original_video_url text,
  processed_video_url text,
  thumbnail_url text,
  duration integer not null default 0,
  aspect_ratio text not null default '9:16',
  resolution text not null default '',
  template_id uuid,
  brand_kit_id uuid,
  tags text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  published_at timestamptz
);

alter table public.projects add column if not exists title text not null default '';
alter table public.projects add column if not exists description text not null default '';
alter table public.projects add column if not exists status text not null default 'draft';
alter table public.projects add column if not exists original_video_url text;
alter table public.projects add column if not exists processed_video_url text;
alter table public.projects add column if not exists thumbnail_url text;
alter table public.projects add column if not exists duration integer not null default 0;
alter table public.projects add column if not exists aspect_ratio text not null default '9:16';
alter table public.projects add column if not exists resolution text not null default '';
alter table public.projects add column if not exists template_id uuid;
alter table public.projects add column if not exists brand_kit_id uuid;
alter table public.projects add column if not exists tags text[] not null default '{}';
alter table public.projects add column if not exists published_at timestamptz;

create table if not exists public.scripts (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  content text not null default '',
  hook_options jsonb not null default '[]'::jsonb,
  selected_hook_id text,
  language text not null default 'id',
  duration_estimate integer not null default 0,
  ai_model_used text,
  generated_at timestamptz not null default now()
);

create table if not exists public.subtitles (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  language text not null default 'id',
  format text not null default 'srt',
  segments jsonb not null default '[]'::jsonb,
  style jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.thumbnails (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references public.projects(id) on delete cascade,
  image_url text not null default '',
  is_variant_a boolean not null default true,
  variant_b_image_url text,
  ctr_prediction numeric(4,3) not null default 0,
  selected_variant text not null default 'a',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.templates (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text not null default '',
  category text not null default 'general',
  thumbnail_url text not null default '',
  preview_video_url text,
  structure jsonb not null default '{}'::jsonb,
  difficulty text not null default 'easy',
  tier text not null default 'free',
  times_used integer not null default 0,
  rating numeric(3,2) not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  tier text not null default 'free',
  status text not null default 'active',
  started_at timestamptz not null default now(),
  expires_at timestamptz,
  cancelled_at timestamptz,
  payment_method text,
  auto_renew boolean not null default false,
  source text not null default 'trial',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.referrals (
  id uuid primary key default gen_random_uuid(),
  referrer_user_id uuid not null references public.profiles(id) on delete cascade,
  referee_user_id uuid references public.profiles(id) on delete set null,
  status text not null default 'pending',
  reward_amount numeric(12,2) not null default 0,
  rewarded_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.brand_kits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  logo_url text,
  primary_color text not null default '#D4AF37',
  secondary_color text not null default '#0B0C10',
  accent_color text not null default '#E6C757',
  primary_font text not null default 'Inter',
  secondary_font text not null default 'JetBrains Mono',
  watermark_url text,
  watermark_position text not null default 'bottom_right',
  intro_video_url text,
  outro_video_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.analytics_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  event_name text not null,
  properties jsonb not null default '{}'::jsonb,
  "timestamp" timestamptz not null default now()
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  body text not null default '',
  type text not null default 'info',
  deep_link text,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.scheduled_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  project_id uuid not null references public.projects(id) on delete cascade,
  scheduled_at timestamptz not null,
  platforms text[] not null default '{}',
  status text not null default 'scheduled',
  created_at timestamptz not null default now()
);

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'projects_template_id_fkey'
  ) then
    alter table public.projects
      add constraint projects_template_id_fkey
      foreign key (template_id) references public.templates(id) on delete set null
      not valid;
  end if;
end $$;

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'projects_brand_kit_id_fkey'
  ) then
    alter table public.projects
      add constraint projects_brand_kit_id_fkey
      foreign key (brand_kit_id) references public.brand_kits(id) on delete set null
      not valid;
  end if;
end $$;

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'profiles_brand_kit_id_fkey'
  ) then
    alter table public.profiles
      add constraint profiles_brand_kit_id_fkey
      foreign key (brand_kit_id) references public.brand_kits(id) on delete set null
      not valid;
  end if;
end $$;

create index if not exists projects_user_id_idx on public.projects(user_id);
create index if not exists scripts_project_id_idx on public.scripts(project_id);
create index if not exists subtitles_project_id_idx on public.subtitles(project_id);
create index if not exists thumbnails_project_id_idx on public.thumbnails(project_id);
create index if not exists subscriptions_user_id_idx on public.subscriptions(user_id);
create index if not exists referrals_referrer_idx on public.referrals(referrer_user_id);
create index if not exists referrals_referee_idx on public.referrals(referee_user_id);
create index if not exists brand_kits_user_id_idx on public.brand_kits(user_id);
create index if not exists analytics_events_user_id_idx on public.analytics_events(user_id);
create index if not exists notifications_user_id_idx on public.notifications(user_id);
create index if not exists scheduled_posts_user_id_idx on public.scheduled_posts(user_id);

alter table public.profiles enable row level security;
alter table public.projects enable row level security;
alter table public.scripts enable row level security;
alter table public.subtitles enable row level security;
alter table public.thumbnails enable row level security;
alter table public.templates enable row level security;
alter table public.subscriptions enable row level security;
alter table public.referrals enable row level security;
alter table public.brand_kits enable row level security;
alter table public.analytics_events enable row level security;
alter table public.notifications enable row level security;
alter table public.scheduled_posts enable row level security;

do $$
begin
  create policy "profiles_select_own" on public.profiles
    for select using (id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "profiles_update_own" on public.profiles
    for update using (id = auth.uid()) with check (id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "profiles_insert_own" on public.profiles
    for insert with check (id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "projects_crud_own" on public.projects
    for all using (user_id = auth.uid()) with check (user_id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "scripts_project_owner" on public.scripts
    for all using (
      exists (
        select 1 from public.projects p
        where p.id = scripts.project_id and p.user_id = auth.uid()
      )
    ) with check (
      exists (
        select 1 from public.projects p
        where p.id = scripts.project_id and p.user_id = auth.uid()
      )
    );
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "subtitles_project_owner" on public.subtitles
    for all using (
      exists (
        select 1 from public.projects p
        where p.id = subtitles.project_id and p.user_id = auth.uid()
      )
    ) with check (
      exists (
        select 1 from public.projects p
        where p.id = subtitles.project_id and p.user_id = auth.uid()
      )
    );
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "thumbnails_project_owner" on public.thumbnails
    for all using (
      exists (
        select 1 from public.projects p
        where p.id = thumbnails.project_id and p.user_id = auth.uid()
      )
    ) with check (
      exists (
        select 1 from public.projects p
        where p.id = thumbnails.project_id and p.user_id = auth.uid()
      )
    );
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "templates_public_select" on public.templates
    for select using (true);
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "templates_service_role_manage" on public.templates
    for all using (auth.role() = 'service_role') with check (auth.role() = 'service_role');
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "subscriptions_select_own" on public.subscriptions
    for select using (user_id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "subscriptions_service_role_manage" on public.subscriptions
    for all using (auth.role() = 'service_role') with check (auth.role() = 'service_role');
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "referrals_select_related" on public.referrals
    for select using (
      referrer_user_id = auth.uid() or referee_user_id = auth.uid()
    );
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "referrals_service_role_manage" on public.referrals
    for all using (auth.role() = 'service_role') with check (auth.role() = 'service_role');
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "brand_kits_crud_own" on public.brand_kits
    for all using (user_id = auth.uid()) with check (user_id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "analytics_events_insert_own" on public.analytics_events
    for insert with check (user_id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "analytics_events_admin_select" on public.analytics_events
    for select using (auth.role() = 'service_role');
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "notifications_select_own" on public.notifications
    for select using (user_id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "notifications_update_own" on public.notifications
    for update using (user_id = auth.uid()) with check (user_id = auth.uid());
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "scheduled_posts_crud_own" on public.scheduled_posts
    for all using (user_id = auth.uid()) with check (user_id = auth.uid());
exception when duplicate_object then null;
end $$;

insert into storage.buckets (id, name, public)
values
  ('avatars', 'avatars', true),
  ('videos', 'videos', false),
  ('thumbnails', 'thumbnails', true),
  ('brand_assets', 'brand_assets', false)
on conflict (id) do nothing;

do $$
begin
  create policy "avatars_public_read" on storage.objects
    for select using (bucket_id = 'avatars');
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "avatars_auth_own_write" on storage.objects
    for all using (
      bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text
    ) with check (
      bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text
    );
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "videos_auth_own_rw" on storage.objects
    for all using (
      bucket_id = 'videos' and (storage.foldername(name))[1] = auth.uid()::text
    ) with check (
      bucket_id = 'videos' and (storage.foldername(name))[1] = auth.uid()::text
    );
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "thumbnails_public_read" on storage.objects
    for select using (bucket_id = 'thumbnails');
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "thumbnails_auth_own_write" on storage.objects
    for all using (
      bucket_id = 'thumbnails' and (storage.foldername(name))[1] = auth.uid()::text
    ) with check (
      bucket_id = 'thumbnails' and (storage.foldername(name))[1] = auth.uid()::text
    );
exception when duplicate_object then null;
end $$;

do $$
begin
  create policy "brand_assets_auth_own_rw" on storage.objects
    for all using (
      bucket_id = 'brand_assets' and (storage.foldername(name))[1] = auth.uid()::text
    ) with check (
      bucket_id = 'brand_assets' and (storage.foldername(name))[1] = auth.uid()::text
    );
exception when duplicate_object then null;
end $$;
