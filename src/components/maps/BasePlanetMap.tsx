// Persona A. Configuración común de Leaflet para los mapas de la Luna y de Marte.
// MoonMap y MarsMap solo eligen el cuerpo; todo lo demás vive aquí.
import L from 'leaflet'
import type { PathOptions } from 'leaflet'
import { MapContainer, TileLayer, GeoJSON } from 'react-leaflet'
import type { Feature, FeatureCollection, Geometry } from 'geojson'
import { LAYERS, type BodyId } from '../../config/layers.ts'

// Mínimo que el mapa necesita de cada zona. El tipo completo vendrá de types/domain.ts (persona C).
export type ZoneProperties = { id: string; name: string }
export type ZoneFeature = Feature<Geometry, ZoneProperties>
export type ZoneCollection = FeatureCollection<Geometry, ZoneProperties>

export type PlanetMapProps = {
  zones: ZoneCollection
  selectedId?: string
  onSelect: (zone: ZoneFeature) => void
}

const baseStyle: PathOptions = { color: '#ffd43b', weight: 1.5, fillOpacity: 0.15 }
const selectedStyle: PathOptions = { color: '#ff6b6b', weight: 3, fillOpacity: 0.3 }

export default function BasePlanetMap({ body, zones, selectedId, onSelect }: PlanetMapProps & { body: BodyId }) {
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
        style={(f) => (f?.properties.id === selectedId ? selectedStyle : baseStyle)}
        onEachFeature={(feature: ZoneFeature, lyr) => {
          lyr.bindTooltip(feature.properties.name)
          lyr.on('click', () => onSelect(feature))
        }}
      />
    </MapContainer>
  )
}
