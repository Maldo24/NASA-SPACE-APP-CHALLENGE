-- =====================================================================
-- Esquema inicial — Análogos Planetarios
-- Modelo: bodies (1) ──< zones (N) >──< zone_analogs >── (N) analogs
--
-- Reglas:
--   * Las coordenadas de zones.geometry van en [lon, lat], lon en [-180, 180].
--   * La relación zona–análogo vive SOLO en zone_analogs.
--   * Borrar una zona borra sus filas en zone_analogs, nunca los análogos.
--   * RLS activo en todas las tablas: el público (anon) solo puede LEER.
--     Las escrituras se hacen con migraciones/seed (service_role o postgres).
-- =====================================================================

-- ---------------------------------------------------------------------
-- bodies: cuerpos celestes (Luna, Marte)
-- ---------------------------------------------------------------------
create table public.bodies (
  id          text primary key check (id in ('moon', 'mars')),
  name        text not null,
  layer_url   text not null,          -- URL WMTS de NASA Trek con {z}/{y}/{x}
  attribution text not null,
  max_zoom    smallint not null default 7 check (max_zoom between 0 and 22)
);

comment on table public.bodies is 'Cuerpos celestes con su capa base de NASA Trek.';

-- ---------------------------------------------------------------------
-- zones: zonas de un cuerpo (polígono GeoJSON)
-- ---------------------------------------------------------------------
create table public.zones (
  id          text primary key check (id ~ '^(moon|mars)-[a-z0-9-]+$'),
  body_id     text not null references public.bodies (id) on delete restrict,
  name        text not null,
  zone_type   text not null,
  description text not null default '',
  geometry    jsonb not null,
  -- el prefijo del id coincide con el cuerpo (mars-xxx pertenece a mars)
  constraint zones_id_matches_body check (split_part(id, '-', 1) = body_id),
  -- geometry debe ser un GeoJSON Polygon con al menos un anillo
  constraint zones_geometry_is_polygon check (
    geometry ->> 'type' = 'Polygon'
    and jsonb_typeof(geometry -> 'coordinates') = 'array'
    and jsonb_array_length(geometry -> 'coordinates') >= 1
  )
);

create index zones_body_id_idx on public.zones (body_id);

comment on table  public.zones is 'Zonas seleccionables en el mapa de cada cuerpo.';
comment on column public.zones.geometry is 'GeoJSON Polygon. Coordenadas en [lon, lat], lon entre -180 y 180.';

-- ---------------------------------------------------------------------
-- analogs: lugares de la Tierra (se reutilizan entre zonas y cuerpos)
-- ---------------------------------------------------------------------
create table public.analogs (
  id       text primary key check (id ~ '^[a-z0-9-]+$'),
  name     text not null,
  category text not null check (category in (
             'geomorphological', 'mineralogical', 'environmental', 'operational')),
  lat      double precision not null check (lat between -90 and 90),
  lon      double precision not null check (lon between -180 and 180),
  why      text not null,
  image    text,                       -- ruta relativa, ej. img/analogs/x.jpg. NULL = foto pendiente
  source   text check (source ~ '^https?://'),  -- URL real. NULL = fuente pendiente
  constraint analogs_image_path check (image is null or image ~ '^img/analogs/[a-z0-9._-]+$')
);

comment on table  public.analogs is 'Análogos terrestres. Un análogo puede usarse en varias zonas de cualquier cuerpo.';
comment on column public.analogs.source is 'Enlace real a la fuente. NULL significa fuente pendiente (no inventar).';
comment on column public.analogs.image  is 'Ruta bajo public/. NULL significa foto pendiente.';

-- ---------------------------------------------------------------------
-- zone_analogs: tabla intermedia N a N
-- ---------------------------------------------------------------------
create table public.zone_analogs (
  zone_id   text not null references public.zones   (id) on delete cascade,
  analog_id text not null references public.analogs (id) on delete restrict,
  primary key (zone_id, analog_id)
);

-- la PK ya indexa por zone_id; este índice acelera "en qué zonas aparece un análogo"
create index zone_analogs_analog_id_idx on public.zone_analogs (analog_id);

comment on table public.zone_analogs is 'Relación N a N entre zonas y análogos.';

-- ---------------------------------------------------------------------
-- Row Level Security: lectura pública, sin escritura desde el cliente
-- (service_role ignora RLS, por eso no necesita políticas de escritura)
-- ---------------------------------------------------------------------
alter table public.bodies       enable row level security;
alter table public.zones        enable row level security;
alter table public.analogs      enable row level security;
alter table public.zone_analogs enable row level security;

create policy "Lectura pública de bodies"       on public.bodies       for select to anon, authenticated using (true);
create policy "Lectura pública de zones"        on public.zones        for select to anon, authenticated using (true);
create policy "Lectura pública de analogs"      on public.analogs      for select to anon, authenticated using (true);
create policy "Lectura pública de zone_analogs" on public.zone_analogs for select to anon, authenticated using (true);

-- Permisos explícitos: solo SELECT para el cliente
revoke all on public.bodies, public.zones, public.analogs, public.zone_analogs from anon, authenticated;
grant select on public.bodies, public.zones, public.analogs, public.zone_analogs to anon, authenticated;
