-- =====================================================================
-- Ya conocido / Propuesto (columna analogs.recognition, migración 20261117000000)
--
-- Criterio:
--   * Bolivia: se respeta el nivel de respaldo de F4 que ya figura en cada ficha.
--     "estudiado" -> known; "propuesto", "sugerido" y candidatos de F2 -> proposed.
--   * Latinoamérica y resto del mundo: son referencias ya usadas por la NASA, otras agencias
--     (ESA, CSA) o la literatura científica (F2, F4, F5, sección 7 del contexto) -> known.
-- Si cambias el respaldo de un análogo en su ficha, actualiza también esta lista.
-- =====================================================================

update public.analogs set recognition = 'known' where id in (
  -- Bolivia, "estudiado" en F4 (o con respaldo de la NASA citado en F2/F4)
  'coipasa', 'glaciares-roca', 'la-salsa', 'laguna-blanca-termal', 'laguna-verde',
  'licancabur', 'pastos-grandes', 'salares-capas', 'uyuni',
  -- Latinoamérica
  'atacama', 'el-tatio',
  -- Resto del mundo
  'basalt', 'cinder-lake', 'concordia', 'grand-canyon', 'haughton', 'haughton-hmp',
  'hi-seas', 'kilauea', 'lanzarote-pangaea', 'lava-river-cave-az', 'mauna-kea-isru',
  'mcmurdo', 'mdrs', 'meteor-crater', 'mistastin', 'qaidam', 'ries-crater', 'rio-tinto',
  'salda', 'sp-mountain', 'tolbachik', 'yakutia'
);

update public.analogs set recognition = 'proposed' where id in (
  -- Bolivia, "propuesto" en F4
  'canapa', 'desierto-dali', 'iturralde', 'siloli', 'tajzara',
  -- Bolivia, "sugerido" en F4
  'cerro-rico', 'cordillera-real', 'guapore', 'intersalar', 'italia-perdida', 'lago-poopo',
  'lago-tauca', 'laguna-colorada', 'ollague', 'permafrost-occidental', 'sajama-hielo',
  'sol-de-manana', 'tata-sabaya', 'torotoro', 'umajalanta',
  -- Bolivia, candidatos o propuestas operacionales de F2
  'sajama', 'sud-lipez', 'valle-de-la-luna'
);
