-- Relación zona ↔ análogo (N a N). Es el ÚNICO lugar donde vive esta relación.
-- Se borra y se vuelve a insertar para que el seed sea la fuente de verdad.
-- Las asociaciones de sitios bolivianos siguen la tabla resumen de F4 (p. 18) y la matriz de F2 (sección 10).
delete from public.zone_analogs;

insert into public.zone_analogs (zone_id, analog_id) values
  -- ======================= MARTE =======================
  -- Meridiani: sulfatos, hierro, aguas ácidas, llanura plana
  ('mars-meridiani', 'rio-tinto'), ('mars-meridiani', 'cerro-rico'), ('mars-meridiani', 'uyuni'),
  ('mars-meridiani', 'atacama'), ('mars-meridiani', 'mdrs'),
  -- Valles Marineris: cañones, capas y deslizamientos
  ('mars-valles-marineris', 'grand-canyon'), ('mars-valles-marineris', 'tata-sabaya'), ('mars-valles-marineris', 'torotoro'),
  -- Jezero: lago antiguo, delta, carbonatos y microbialitos
  ('mars-jezero', 'salda'), ('mars-jezero', 'laguna-verde'), ('mars-jezero', 'pastos-grandes'),
  ('mars-jezero', 'licancabur'), ('mars-jezero', 'lago-poopo'),
  ('mars-jezero', 'mdrs'), ('mars-jezero', 'sud-lipez'),
  -- Gale: capas sedimentarias, lago antiguo, boro
  ('mars-gale', 'salares-capas'), ('mars-gale', 'laguna-colorada'), ('mars-gale', 'licancabur'),
  ('mars-gale', 'torotoro'), ('mars-gale', 'valle-de-la-luna'), ('mars-gale', 'sud-lipez'), ('mars-gale', 'mdrs'),
  -- Olympus Mons / Tharsis: volcanes, coladas, colapsos de flanco
  ('mars-olympus-mons', 'tata-sabaya'), ('mars-olympus-mons', 'ollague'), ('mars-olympus-mons', 'intersalar'),
  ('mars-olympus-mons', 'kilauea'), ('mars-olympus-mons', 'sajama'), ('mars-olympus-mons', 'basalt'), ('mars-olympus-mons', 'hi-seas'),
  -- Aureum Chaos: terreno caótico, salares (NASA)
  ('mars-aureum-chaos', 'uyuni'), ('mars-aureum-chaos', 'coipasa'), ('mars-aureum-chaos', 'lago-tauca'),
  -- Gusev / Home Plate: hidrotermalismo y sílice
  ('mars-gusev-home-plate', 'el-tatio'), ('mars-gusev-home-plate', 'sol-de-manana'), ('mars-gusev-home-plate', 'la-salsa'),
  ('mars-gusev-home-plate', 'laguna-blanca-termal'),
  -- Utopia: hielo del suelo, polígonos, cráteres degradados
  ('mars-utopia-planitia', 'uyuni'), ('mars-utopia-planitia', 'iturralde'),
  ('mars-utopia-planitia', 'mcmurdo'), ('mars-utopia-planitia', 'permafrost-occidental'), ('mars-utopia-planitia', 'haughton-hmp'),
  -- Icaria Planum: cloruros y salmueras
  ('mars-icaria-planum', 'uyuni'), ('mars-icaria-planum', 'coipasa'), ('mars-icaria-planum', 'canapa'),
  -- Medusae Fossae: erosión eólica
  ('mars-medusae-fossae', 'siloli'), ('mars-medusae-fossae', 'italia-perdida'), ('mars-medusae-fossae', 'tajzara'),
  ('mars-medusae-fossae', 'desierto-dali'),
  -- Deuteronilus Mensae: glaciares cubiertos de detritos
  ('mars-deuteronilus-mensae', 'glaciares-roca'),
  -- Planum Boreum: capas de hielo como archivo climático
  ('mars-planum-boreum', 'sajama-hielo'), ('mars-planum-boreum', 'cordillera-real'),
  -- Mawrth Vallis: corteza antigua alterada
  ('mars-mawrth-vallis', 'guapore'),

  -- ======================= LUNA =======================
  ('moon-tranquillitatis', 'kilauea'), ('moon-tranquillitatis', 'basalt'), ('moon-tranquillitatis', 'lanzarote-pangaea'),
  ('moon-tycho', 'meteor-crater'), ('moon-tycho', 'haughton'),
  ('moon-shackleton', 'mcmurdo'), ('moon-shackleton', 'concordia'),
  ('moon-marius-hills', 'kilauea'), ('moon-marius-hills', 'lanzarote-pangaea'), ('moon-marius-hills', 'umajalanta');
