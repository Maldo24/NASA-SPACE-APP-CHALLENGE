// Persona 1. Mapa del cuerpo celeste + polígonos de zonas clicables.
import L from 'leaflet'
import { MapContainer, TileLayer, GeoJSON } from 'react-leaflet'
import { LAYERS } from '../config/layers.js'

const baseStyle = { color: '#ffd43b', weight: 1.5, fillOpacity: 0.15 }
const selectedStyle = { color: '#ff6b6b', weight: 3, fillOpacity: 0.3 }

export default function PlanetMap({ body, zones, selectedId, onSelect }) {
  const layer = LAYERS[body]

  return (
    <MapContainer
      className="planet-map"
      crs={L.CRS.EPSG4326}          // tiles de Trek son equirectangulares
      center={[0, 0]}
      zoom={1}
      minZoom={0}
      maxZoom={layer.maxZoom}
      worldCopyJump={false}
    >
      <TileLayer url={layer.url} attribution={layer.attribution} noWrap tileSize={256} />
      <GeoJSON
        key={selectedId ?? 'none'}   // re-render para actualizar el estilo seleccionado
        data={zones}
        style={(f) => (f.properties.id === selectedId ? selectedStyle : baseStyle)}
        onEachFeature={(feature, lyr) => {
          lyr.bindTooltip(feature.properties.name)
          lyr.on('click', () => onSelect(feature))
        }}
      />
    </MapContainer>
  )
}
