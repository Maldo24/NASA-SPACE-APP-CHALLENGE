# Análogos Planetarios — NASA Space Apps

Selecciona una zona de la Luna o de Marte y mira qué tipo de terreno es y cuáles son sus **análogos en la Tierra**
en 4 categorías: geomorfológico, mineralógico, ambiental y operacional.

## Correr
```bash
npm install
npm run dev
```

## Estructura
```
index.html
vite.config.js
public/img/analogs/        # fotos de los análogos (referenciadas como "img/analogs/x.jpg")
src/
  main.jsx                 # entrada
  App.jsx                  # estado global: body, selectedZone
  App.css                  # estilos
  config/
    layers.js              # URLs WMTS de NASA Trek (Luna / Marte)
    categories.js          # las 4 categorías de análogos
  lib/
    data.js                # ÚNICO punto de acceso a los datos
  data/
    zones-moon.json        # GeoJSON de zonas lunares
    zones-mars.json        # GeoJSON de zonas marcianas
    analogs.json           # análogos terrestres (se reutilizan entre zonas)
  components/
    BodySwitcher.jsx       # Luna / Marte
    PlanetMap.jsx          # Leaflet EPSG4326 + polígonos clicables
    ZonePanel.jsx          # info de zona + análogos
    CategoryTabs.jsx       # 4 pestañas
    AnalogCard.jsx         # tarjeta de análogo
    EarthMiniMap.jsx       # ubicación del análogo en la Tierra
```

## Contrato de datos (no cambiar sin avisar al equipo)

**Zona** (`Feature` en `zones-*.json`; las coordenadas van en `[lon, lat]`, con lon entre -180 y 180):
```json
{ "id": "mars-xxx", "name": "", "zoneType": "", "description": "", "analogIds": ["..."] }
```

**Análogo** (`analogs.json`):
```json
{ "id": "", "name": "", "category": "geomorphological|mineralogical|environmental|operational",
  "lat": 0, "lon": 0, "why": "", "image": "img/analogs/x.jpg", "source": "https://..." }
```

## Reparto
| Persona | Archivos |
|---|---|
| 1 · Mapa | `PlanetMap.jsx`, `BodySwitcher.jsx`, `config/layers.js` |
| 2 · UI | `ZonePanel.jsx`, `CategoryTabs.jsx`, `AnalogCard.jsx`, `EarthMiniMap.jsx`, `App.css` |
| 3 · Datos Marte | `data/zones-mars.json`, análogos de Marte en `analogs.json`, fotos |
| 4 · Datos Luna + deploy | `data/zones-moon.json`, análogos de la Luna en `analogs.json`, deploy, pitch |

Para dibujar los polígonos: geojson.io (con un mapa de referencia de Trek al lado para guiarse).
