-- PodKedd tábla: kedvencek, meghallgatott-jelölések és saját sztorik, felhasználónként
create table if not exists public.podkedd (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  id text not null,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  deleted boolean not null default false,
  primary key (user_id, id)
);
alter table public.podkedd enable row level security;
create policy "podkedd select" on public.podkedd for select using (auth.uid() = user_id);
create policy "podkedd insert" on public.podkedd for insert with check (auth.uid() = user_id);
create policy "podkedd update" on public.podkedd for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "podkedd delete" on public.podkedd for delete using (auth.uid() = user_id);
