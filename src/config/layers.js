// Persona 1 (Mapa). Capas base WMTS de NASA Trek (proyección equirectangular -> L.CRS.EPSG4326).
// TODO: verificar URLs en trek.nasa.gov (Layer -> info -> WMTS) y maxZoom de cada mosaico.
export const LAYERS = {
  moon: {
    name: 'Luna',
    url: 'https://trek.nasa.gov/tiles/Moon/EQ/LRO_WAC_Mosaic_Global_303ppd_v02/1.0.0/default/default028mm/{z}/{y}/{x}.jpg',
    attribution: 'NASA Moon Trek · LRO WAC',
    maxZoom: 7,
  },
  mars: {
    name: 'Marte',
    url: 'https://trek.nasa.gov/tiles/Mars/EQ/Mars_Viking_MDIM21_ClrMosaic_global_232m/1.0.0/default/default028mm/{z}/{y}/{x}.jpg',
    attribution: 'NASA Mars Trek · Viking MDIM2.1',
    maxZoom: 7,
  },
}
