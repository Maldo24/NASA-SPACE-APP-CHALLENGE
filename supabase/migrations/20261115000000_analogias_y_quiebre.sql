-- =====================================================================
-- Analogías parciales y punto de quiebre de cada análogo
--
-- Cada análogo ya tiene su analogía principal en `category` (a la que más se acerca).
-- Esta migración añade:
--   * secondary_categories: otras de las 4 analogías que el sitio cumple de forma parcial.
--   * breaking_point: lo que el sitio NO llega a representar del lugar de la Luna o Marte
--     con el que se compara (su límite como análogo). NULL = pendiente.
-- Los valores se cargan en supabase/seed/05_analogias_quiebre.sql.
-- =====================================================================

alter table public.analogs
  add column secondary_categories text[] not null default '{}',
  add column breaking_point text;

alter table public.analogs
  add constraint analogs_secondary_categories_valid check (
    secondary_categories <@ array['geomorphological', 'mineralogical', 'environmental', 'operational']::text[]
    and not (category = any (secondary_categories))
  );

comment on column public.analogs.secondary_categories is
  'Otras analogías que el sitio cumple en parte. No incluye la principal (category).';
comment on column public.analogs.breaking_point is
  'Lo que el sitio no llega a representar del lugar de la Luna o Marte. NULL = pendiente.';
