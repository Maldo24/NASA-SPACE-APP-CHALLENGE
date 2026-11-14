-- Relación zona ↔ análogo (N a N). Es el ÚNICO lugar donde vive esta relación.
-- Se borra y se vuelve a insertar para que el seed sea la fuente de verdad.
delete from public.zone_analogs;

insert into public.zone_analogs (zone_id, analog_id) values
  -- Marte
  ('mars-meridiani', 'rio-tinto'), ('mars-meridiani', 'atacama'), ('mars-meridiani', 'uyuni'), ('mars-meridiani', 'mdrs'),
  ('mars-valles-marineris', 'grand-canyon'), ('mars-valles-marineris', 'torotoro'),
  ('mars-jezero', 'salda'), ('mars-jezero', 'licancabur'), ('mars-jezero', 'mdrs'),
  ('mars-gale', 'licancabur'), ('mars-gale', 'torotoro'), ('mars-gale', 'mdrs'),
  ('mars-olympus-mons', 'kilauea'), ('mars-olympus-mons', 'basalt'), ('mars-olympus-mons', 'hi-seas'), ('mars-olympus-mons', 'sajama'),
  ('mars-aureum-chaos', 'uyuni'),
  ('mars-gusev-home-plate', 'el-tatio'),
  ('mars-utopia-planitia', 'mcmurdo'), ('mars-utopia-planitia', 'haughton-hmp'),
  -- Luna
  ('moon-tranquillitatis', 'kilauea'), ('moon-tranquillitatis', 'basalt'), ('moon-tranquillitatis', 'lanzarote-pangaea'),
  ('moon-tycho', 'meteor-crater'), ('moon-tycho', 'haughton'),
  ('moon-shackleton', 'mcmurdo'), ('moon-shackleton', 'concordia'),
  ('moon-marius-hills', 'kilauea'), ('moon-marius-hills', 'lanzarote-pangaea');
