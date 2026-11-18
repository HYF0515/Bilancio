-- Bilancio Personale: schema del database.
-- Incolla tutto in Supabase -> SQL Editor -> New query, poi premi Run.

create table if not exists public.docs (
  user_id    uuid        not null default auth.uid() references auth.users (id) on delete cascade,
  col        text        not null,               -- accounts, categories, transactions, holdings, goals, recurring, snapshots, settings
  id         text        not null,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, col, id)
);

-- Ogni utente vede e modifica solo le proprie righe.
alter table public.docs enable row level security;

drop policy if exists "docs_select_own" on public.docs;
drop policy if exists "docs_insert_own" on public.docs;
drop policy if exists "docs_update_own" on public.docs;
drop policy if exists "docs_delete_own" on public.docs;

create policy "docs_select_own" on public.docs for select to authenticated using (auth.uid() = user_id);
create policy "docs_insert_own" on public.docs for insert to authenticated with check (auth.uid() = user_id);
create policy "docs_update_own" on public.docs for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "docs_delete_own" on public.docs for delete to authenticated using (auth.uid() = user_id);
