// Persona A. Configuración común de Leaflet para los mapas de la Luna y de Marte.
// MoonMap y MarsMap solo eligen el cuerpo; todo lo demás vive aquí.
import { useEffect, useMemo, useState } from 'react'
import L from 'leaflet'
import type { PathOptions } from 'leaflet'
import { MapContainer, TileLayer, GeoJSON } from 'react-leaflet'
import type { Feature, FeatureCollection, Polygon as GeoPolygon } from 'geojson'
import { LAYERS } from '../../config/layers.ts'
import { getZones } from '../../lib/data.ts'
import type { BodyId, Zone } from '../../types/domain.ts'

export type PlanetMapProps = {
  selectedId?: string
  onSelect: (zone: Zone) => void
}

type ZoneFeature = Feature<GeoPolygon, { id: string; name: string }>

const baseStyle: PathOptions = { color: '#ffd43b', weight: 1.5, fillOpacity: 0.15 }
const selectedStyle: PathOptions = { color: '#ff6b6b', weight: 3, fillOpacity: 0.3 }

// Zonas del cuerpo, cargadas desde lib/data.ts. null = cargando.
function useZones(body: BodyId) {
  const [zones, setZones] = useState<Zone[] | null>(null)
  useEffect(() => {
    let alive = true
    setZones(null)
    getZones(body)
      .then((z) => { if (alive) setZones(z) })
      .catch((err) => { console.error(`No se pudieron cargar las zonas de ${body}`, err); if (alive) setZones([]) })
    return () => { alive = false }
  }, [body])
  return zones
}

export default function BasePlanetMap({ body, selectedId, onSelect }: PlanetMapProps & { body: BodyId }) {
  const layer = LAYERS[body]
  const zones = useZones(body)

  // Leaflet dibuja GeoJSON; Zone guarda solo la geometría, así que se arma la colección aquí.
  const collection = useMemo<FeatureCollection<GeoPolygon, ZoneFeature['properties']>>(() => ({
    type: 'FeatureCollection',
    features: (zones ?? []).map((z) => ({
      type: 'Feature',
      properties: { id: z.id, name: z.name },
      geometry: z.geometry,
    })),
  }), [zones])

  const zoneById = useMemo(() => new Map((zones ?? []).map((z) => [z.id, z])), [zones])

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
      {zones && (
        <GeoJSON
          key={`${zones.length}-${selectedId ?? 'none'}`}   // re-render al cargar y al cambiar la selección
          data={collection}
          style={(f) => (f?.properties.id === selectedId ? selectedStyle : baseStyle)}
          onEachFeature={(feature: ZoneFeature, lyr) => {
            lyr.bindTooltip(feature.properties.name)
            lyr.on('click', () => {
              const zone = zoneById.get(feature.properties.id)
              if (zone) onSelect(zone)
            })
          }}
        />
      )}
    </MapContainer>
  )
}
