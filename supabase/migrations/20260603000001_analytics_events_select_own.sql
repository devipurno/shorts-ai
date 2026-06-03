-- Allow authenticated users to read their own analytics events.
do $$
begin
  create policy "analytics_events_select_own" on public.analytics_events
    for select using (user_id = auth.uid());
exception when duplicate_object then null;
end $$;
