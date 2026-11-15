-- =====================================================================
-- Reconocimiento de cada análogo: ya conocido o propuesto
--
--   * known:    ya lo usa o lo estudió como análogo la NASA, otra agencia espacial o una
--               publicación científica (en F4: "estudiado"; los sitios internacionales).
--   * proposed: sale de la investigación del equipo o de los informes F2/F4 con desarrollo
--               limitado (en F4: "propuesto" o "sugerido"; candidatos de F2).
--   * NULL:     pendiente de clasificar.
--
-- Es la categoría que atribuyen las fuentes, no una certificación externa
-- (CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, secciones 5 y 12).
-- Los valores se cargan en supabase/seed/11_reconocimiento.sql.
-- =====================================================================

alter table public.analogs
  add column recognition text;

alter table public.analogs
  add constraint analogs_recognition_valid check (recognition in ('known', 'proposed'));

comment on column public.analogs.recognition is
  'known = ya usado o estudiado como análogo; proposed = propuesto por la investigación. NULL = pendiente.';
