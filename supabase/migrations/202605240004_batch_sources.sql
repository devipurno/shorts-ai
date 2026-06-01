alter table source_videos add column if not exists youtube_url text;

update source_videos
set youtube_url = source_url
where youtube_url is null
  and source_url is not null;

create unique index if not exists idx_source_videos_unique_youtube_url_per_project
on source_videos(project_id, youtube_url)
where youtube_url is not null;

create or replace function public.enforce_source_videos_batch_limit()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if tg_op = 'INSERT' then
    if (
      select count(*)
      from source_videos
      where project_id = new.project_id
    ) >= 10 then
      raise exception 'A batch can contain a maximum of 10 source videos.'
        using errcode = '23514';
    end if;
  end if;

  return new;
end;
$$;

drop trigger if exists enforce_source_videos_batch_limit on source_videos;

create trigger enforce_source_videos_batch_limit
before insert on source_videos
for each row
execute function public.enforce_source_videos_batch_limit();
