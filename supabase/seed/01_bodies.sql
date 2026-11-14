-- Cuerpos celestes. Las URLs deben coincidir con src/config/layers.ts (dueño: A).
-- TODO: verificar URLs y max_zoom en trek.nasa.gov (Layer -> info -> WMTS).
insert into public.bodies (id, name, layer_url, attribution, max_zoom) values
  ('moon', 'Luna',
   'https://trek.nasa.gov/tiles/Moon/EQ/LRO_WAC_Mosaic_Global_303ppd_v02/1.0.0/default/default028mm/{z}/{y}/{x}.jpg',
   'NASA Moon Trek · LRO WAC', 7),
  ('mars', 'Marte',
   'https://trek.nasa.gov/tiles/Mars/EQ/Mars_Viking_MDIM21_ClrMosaic_global_232m/1.0.0/default/default028mm/{z}/{y}/{x}.jpg',
   'NASA Mars Trek · Viking MDIM2.1', 7)
on conflict (id) do update set
  name = excluded.name, layer_url = excluded.layer_url,
  attribution = excluded.attribution, max_zoom = excluded.max_zoom;
