# Análogos Planetarios — NASA Space Apps

Web con dos mapas, uno de la **Luna** (`/luna`) y otro de **Marte** (`/marte`). Tocas una zona y ves qué tipo
de terreno es y sus **análogos terrestres** en 4 categorías:

| Categoría | Qué significa |
|---|---|
| Geomorfológico | La forma del relieve se parece (cráteres, canales, dunas). |
| Mineralógico / geoquímico | Las rocas o minerales son parecidos (basaltos, arcillas, sulfatos). |
| Ambiental / habitabilidad | Condiciones extremas parecidas (frío, aridez, UV, salinidad). |
| Operacional | Sirve para entrenar astronautas y probar rovers, trajes y hábitats. |

Cada análogo muestra su foto, por qué se parece, un mini mapa con su ubicación y su fuente.

## Correr en local

Necesitas Node.js LTS.

```bash
npm install
npm run dev        # abre http://localhost:5173/luna o /marte
npm run build      # debe terminar sin errores antes de abrir un PR
```

### Datos: sin base de datos en el MVP

Decisión del equipo: el MVP **no usa base de datos**. Los datos son de solo lectura y viven en
`src/data/*.json`, que `lib/data.ts` lee cuando no hay credenciales. No hace falta configurar nada.

- La fuente de verdad de los datos es el SQL de [supabase/seed/](supabase/seed/). Los JSON se **generan**
  desde ahí con `bash supabase/seed/exportar-json.sh` (necesita podman o docker). No edites los JSON a mano.
- El esquema de Supabase queda listo para después. Para activarlo basta crear el proyecto, cargar la
  migración y el seed, y poner en `.env.local` y en Vercel:

```
VITE_SUPABASE_URL=https://<proyecto>.supabase.co
VITE_SUPABASE_ANON_KEY=<clave anon>
```

Solo va la clave **anon**. La `service_role` nunca va en el frontend ni en el repo.

### Contenido actual

17 zonas (4 en la Luna, 13 en Marte) y 51 análogos, de los cuales 36 están en Bolivia o en su frontera.
Cada análogo boliviano indica su nivel de respaldo según el documento F4: **estudiado**, **propuesto** o **sugerido**.

## Stack

- React 18 + Vite + TypeScript estricto (los `.jsx` existentes se migran al tocarlos)
- Leaflet + react-leaflet, con teselas de NASA Trek (proyección equirectangular, `L.CRS.EPSG4326`)
- React Router (`/luna`, `/marte`)
- Datos estáticos en JSON para el MVP; esquema de Supabase (Postgres con RLS) listo para una etapa posterior
- Vercel: cada PR genera un preview y `main` despliega a producción

## Modelo de datos

```
bodies (1) ──< zones (N) >──< zone_analogs >── (N) analogs
```

| Tabla | Campos | Notas |
|---|---|---|
| `bodies` | `id` (`moon`/`mars`), `name`, `layer_url`, `attribution`, `max_zoom` | Capa base de NASA Trek. |
| `zones` | `id` (`mars-…`), `body_id`, `name`, `zone_type`, `description`, `geometry` | `geometry` es un GeoJSON Polygon en `[lon, lat]`, lon entre -180 y 180. |
| `analogs` | `id`, `name`, `category`, `lat`, `lon`, `why`, `image`, `source` | Se reutiliza entre zonas y cuerpos. `image`/`source` en `null` = pendiente. |
| `zone_analogs` | `zone_id`, `analog_id` (PK compuesta) | Única fuente de la relación N a N. |

- Borrar una zona borra sus filas en `zone_analogs`, nunca los análogos.
- La base no deja borrar un análogo que una zona todavía usa.
- El público solo puede leer (RLS). Las escrituras se hacen con migraciones y seeds.

Esquema: [supabase/migrations/](supabase/migrations/). Datos: [supabase/seed/](supabase/seed/).
Cómo cargarlos: [supabase/README.md](supabase/README.md). Tipos TypeScript: [src/types/domain.ts](src/types/domain.ts).

### Contrato de `src/lib/data.ts`

Es el **único** punto de acceso a datos. Los componentes nunca llaman a Supabase directamente.

| Función | Devuelve |
|---|---|
| `getBodies()` | `Promise<Body[]>` |
| `getZones(bodyId)` | `Promise<Zone[]>` |
| `getZone(zoneId)` | `Promise<Zone \| null>` |
| `getAnalogsForZone(zoneId)` | `Promise<AnalogsByCategory>`: siempre trae las 4 categorías (las vacías como `[]`) |

## Estructura

```
index.html
vite.config.ts
public/img/analogs/          fotos de los análogos (C)
supabase/
  migrations/                SQL versionado y RLS (C)
  seed/                      datos iniciales de Luna, Marte y análogos (C)
docs/PITCH.md                guion del pitch (C)
src/
  main.tsx                   entrada
  App.tsx                    rutas (/luna, /marte) y zona seleccionada (A)
  App.css                    (B)
  types/domain.ts            tipos: Body, Zone, Analog, Category (C)
  config/
    layers.ts                URLs WMTS de NASA Trek (A)
    categories.ts            las 4 categorías (B)
  lib/
    supabase.ts              cliente de Supabase (A)
    data.ts                  ÚNICO punto de acceso a datos (A)
  components/
    maps/
      BasePlanetMap.tsx      configuración común de Leaflet (A)
      MoonMap.tsx            mapa de la Luna (A)
      MarsMap.tsx            mapa de Marte (A)
    ZonePanel.tsx            información de la zona y sus análogos (B)
    CategoryTabs.tsx         pestañas de categoría (B)
    AnalogCard.tsx           tarjeta de cada análogo (B)
    EarthMiniMap.tsx         ubicación del análogo en la Tierra (A)
```

`src/data/*.json` son los datos que usa el MVP, generados desde `supabase/seed/`. Si algún día se conecta Supabase, la app los usa solo como respaldo.

## Reparto (propuesta, pendiente de confirmar)

| Persona | Qué hace |
|---|---|
| A · Sebastián | Mapas de la Luna y Marte, mini mapa de la Tierra, rutas, `lib/data.ts` y cliente de Supabase |
| B · Santiago | Interfaz (panel, pestañas, tarjetas, estilos), deploy en Vercel y pruebas en escritorio y móvil |
| C · Maldo | Esquema y migraciones de Supabase, carga de datos de la Luna y Marte, fotos y fuentes, pitch y documentación |

C define el esquema y A lo consume en `data.ts`. B prueba en los previews de Vercel.
`App.tsx` y `lib/data.ts` tienen un solo dueño (A); los demás piden cambios por PR.

## Reglas de trabajo

- Cada persona trabaja en su propia rama y abre un PR hacia `main`. Nadie hace push directo a `main`.
- Revisión cruzada: A revisa a B, B revisa a C y C revisa a A.
- Commits pequeños, con mensajes en español.
- Si cambias el modelo, los IDs, los nombres de campos o las funciones de `data.ts`, avisa al equipo.
- No modifiques `tmp/` ni los PDFs de fuentes.
- Antes de afirmar un dato científico, revisa `CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md` (sección 12).
- Cada análogo tiene una fuente con un enlace real, o queda marcado como pendiente. No se inventan fuentes.
