-- =====================================================================
-- Profundización: ficha de cada zona, límites por analogía y entrenamientos
--
-- Paso 0 del reparto (docs/REPARTO.md). Solo crea la estructura; los datos los
-- carga cada persona en su propio archivo de supabase/seed/:
--   06_limites.sql          (Maldo)     -> analog_aspects
--   07_zonas.sql            (Santiago)  -> columnas nuevas de zones y zonas nuevas
--   08_entrenamientos.sql   (Sebastián) -> analog_trainings
--   09_analogos_nuevos.sql  (Sebastián) -> análogos nuevos completos
-- =====================================================================

-- Comprueba que todos los elementos de un arreglo sean URLs http(s). Arreglo vacío = válido.
create function public.all_urls(urls text[]) returns boolean
language sql immutable
as $$ select coalesce(bool_and(u ~ '^https?://'), true) from unnest(urls) as u $$;

-- ---------------------------------------------------------------------
-- 1. Ficha completa de cada zona (tarea 2)
-- ---------------------------------------------------------------------
alter table public.zones
  add column geology     text,                         -- qué es y cómo se formó
  add column environment text,                         -- temperatura, radiación, luz, polvo...
  add column exploration text,                         -- misiones que la observaron o visitaron, y estado
  add column importance  text,                         -- por qué interesa estudiarla
  add column sources     text[] not null default '{}', -- enlaces que respaldan la ficha
  add constraint zones_sources_are_urls check (public.all_urls(sources));

comment on column public.zones.geology     is 'Qué es la zona y cómo se formó. NULL = pendiente.';
comment on column public.zones.environment is 'Condiciones del lugar: temperatura, radiación, luz, polvo. NULL = pendiente.';
comment on column public.zones.exploration is 'Misiones que la estudiaron o visitaron y su estado. NULL = pendiente.';
comment on column public.zones.importance  is 'Por qué interesa a la ciencia o a la exploración. NULL = pendiente.';
comment on column public.zones.sources     is 'URLs reales que respaldan la ficha de la zona.';

-- ---------------------------------------------------------------------
-- 2. Qué cubre y dónde se rompe cada análogo, por tipo de analogía (tarea 1)
--    Una fila por análogo y por categoría que cumple (principal o secundaria).
--    Una categoría sin fila = el análogo no la cubre.
-- ---------------------------------------------------------------------
create table public.analog_aspects (
  analog_id text not null references public.analogs (id) on delete cascade,
  category  text not null check (category in (
              'geomorphological', 'mineralogical', 'environmental', 'operational')),
  covers    text not null check (length(trim(covers)) > 0),  -- qué reproduce en esta categoría
  breaks    text not null check (length(trim(breaks)) > 0),  -- dónde se rompe la analogía en esta categoría
  source    text check (source ~ '^https?://'),               -- respaldo específico. NULL = el del análogo
  primary key (analog_id, category)
);

comment on table  public.analog_aspects is 'Para cada análogo y cada tipo de analogía que cumple: qué reproduce y dónde se rompe.';
comment on column public.analog_aspects.covers is 'Qué reproduce el sitio en esta categoría.';
comment on column public.analog_aspects.breaks is 'Dónde deja de servir la analogía en esta categoría.';

-- ---------------------------------------------------------------------
-- 3. Entrenamientos posibles en cada análogo (tarea 3)
-- ---------------------------------------------------------------------
create table public.analog_trainings (
  analog_id    text not null references public.analogs (id) on delete cascade,
  position     smallint not null check (position between 1 and 9),  -- orden dentro del análogo
  audience     text not null check (audience in (
                 'astronauts', 'rovers', 'suits', 'habitats', 'science')),
  activity     text not null check (length(trim(activity)) > 0),  -- qué se practica
  measures     text not null check (length(trim(measures)) > 0),  -- qué se mide para evaluarlo
  restrictions text,                                              -- permisos, seguridad, conservación
  source       text check (source ~ '^https?://'),                -- respaldo específico. NULL = el del análogo
  primary key (analog_id, position)
);

comment on table  public.analog_trainings is 'Actividades de entrenamiento o prueba posibles en cada análogo.';
comment on column public.analog_trainings.audience is 'Para quién: astronauts, rovers, suits (trajes), habitats o science.';

-- ---------------------------------------------------------------------
-- RLS: lectura pública, sin escritura desde el cliente (igual que el resto)
-- ---------------------------------------------------------------------
alter table public.analog_aspects   enable row level security;
alter table public.analog_trainings enable row level security;

create policy "Lectura pública de analog_aspects"   on public.analog_aspects   for select to anon, authenticated using (true);
create policy "Lectura pública de analog_trainings" on public.analog_trainings for select to anon, authenticated using (true);

revoke all on public.analog_aspects, public.analog_trainings from anon, authenticated;
grant select on public.analog_aspects, public.analog_trainings to anon, authenticated;
