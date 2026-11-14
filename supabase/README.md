# Base de datos (Supabase)

Dueño: C. Ver el modelo completo en el [README principal](../README.md#modelo-de-datos).

```
supabase/
  migrations/   esquema (tablas, relaciones, RLS). Un archivo por cambio, nunca se edita uno ya aplicado.
  seed/         datos iniciales, en orden: 01_bodies → 02_analogs → 03_zones → 04_zone_analogs
```

## Reglas
- Nadie cambia tablas a mano en el panel de Supabase. Un cambio de esquema es un **nuevo** archivo en `migrations/`
  con nombre `AAAAMMDDhhmmss_descripcion.sql`.
- Todas las tablas tienen RLS. El público (clave `anon`) solo puede **leer**. Nadie escribe desde la app.
- La relación zona–análogo vive solo en `zone_analogs`.
- Los seeds se pueden correr varias veces: actualizan lo que ya existe en vez de duplicar.

## Cómo cargar la base por primera vez

Necesitas el "Connection string" del proyecto (Supabase → Project Settings → Database → URI).
Es secreto: no lo pegues en el repo ni en el chat del equipo.

```bash
# 1. Conectar el repo con el proyecto de Supabase (te pide iniciar sesión)
npx supabase login
npx supabase link --project-ref <id-del-proyecto>

# 2. Aplicar las migraciones (crea las tablas y el RLS)
npx supabase db push

# 3. Cargar los datos, en orden
for f in supabase/seed/*.sql; do psql "$SUPABASE_DB_URL" -v ON_ERROR_STOP=1 -f "$f"; done
```

Si no tienes `psql`, puedes pegar los 4 archivos de `seed/` **en orden** en el SQL Editor de Supabase.
Son datos, no cambios de esquema, así que no rompe la regla.

## Cómo agregar datos
- **Análogo nuevo:** agrega una fila en `02_analogs.sql`. `source` debe ser un enlace real que abra; si no lo tienes, pon `null` (pendiente).
- **Zona nueva:** agrega una fila en `03_zones.sql`. El id empieza con el cuerpo (`mars-…`, `moon-…`). Coordenadas en `[lon, lat]`, lon entre -180 y 180.
- **Relacionarlos:** agrega el par en `04_zone_analogs.sql`.
- Vuelve a correr los seeds.

## Validaciones que hace la base
La base rechaza: categorías que no sean las 4, lat/lon fuera de rango, `source` que no empiece con `http`,
geometrías que no sean `Polygon`, zonas cuyo prefijo no coincida con el cuerpo, y borrar un análogo que
alguna zona todavía usa.
