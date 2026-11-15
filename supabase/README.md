# Base de datos (Supabase)

Dueño: C. Ver el modelo completo en el [README principal](../README.md#modelo-de-datos).

```
supabase/
  migrations/   esquema (tablas, relaciones, RLS). Un archivo por cambio, nunca se edita uno ya aplicado.
  seed/         datos, en orden: 01_bodies → 02_analogs → 03_zones → 04_zone_analogs → 05_analogias_quiebre
                → 06_limites (Maldo) → 07_zonas (Santiago) → 08_entrenamientos y 09_analogos_nuevos (Sebastián).
                Reparto y reglas: docs/REPARTO.md
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

Si no tienes `psql`, puedes pegar los archivos `.sql` de `seed/` **en orden** en el SQL Editor de Supabase.
Son datos, no cambios de esquema, así que no rompe la regla.

## Cómo agregar datos
Mientras dure el reparto de [docs/REPARTO.md](../docs/REPARTO.md), los archivos `01`–`05` no se editan:
- **Análogo nuevo (completo):** en `09_analogos_nuevos.sql` (Sebastián). `source` debe ser un enlace real que abra; si no lo tienes, pon `null` (pendiente).
- **Zona nueva y su ficha:** en `07_zonas.sql` (Santiago). El id empieza con el cuerpo (`mars-…`, `moon-…`). Coordenadas en `[lon, lat]`, lon entre -180 y 180.
- **Límites por analogía:** en `06_limites.sql` (Maldo). **Entrenamientos:** en `08_entrenamientos.sql` (Sebastián).
- **Relacionar zona y análogo:** en el archivo de quien crea la zona o el análogo nuevo.
- Vuelve a correr los seeds.
- Regenera la semilla JSON de respaldo (la que usa la app sin credenciales de Supabase):
  `bash supabase/seed/exportar-json.sh` (necesita podman o docker). No edites `src/data/*.json` a mano.

## Validaciones que hace la base
La base rechaza: categorías que no sean las 4, lat/lon fuera de rango, `source` que no empiece con `http`,
geometrías que no sean `Polygon`, zonas cuyo prefijo no coincida con el cuerpo, y borrar un análogo que
alguna zona todavía usa.
