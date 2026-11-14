// Persona A. Configuración común de Leaflet para los mapas de la Luna y de Marte.
// MoonMap y MarsMap solo eligen el cuerpo; todo lo demás vive aquí.
import { useEffect, useMemo, useState } from 'react'
import L from 'leaflet'
import type { PathOptions } from 'leaflet'
import { MapContainer, TileLayer, GeoJSON, CircleMarker, Tooltip, useMap } from 'react-leaflet'
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

const markerStyle: PathOptions = { color: '#1a1300', weight: 1.5, fillColor: '#ffd43b', fillOpacity: 0.95 }
const markerSelectedStyle: PathOptions = { color: '#fff', weight: 2, fillColor: '#ff6b6b', fillOpacity: 1 }

// Centro del rectángulo que envuelve la zona, en [lat, lon] (la geometría guarda [lon, lat]).
function zoneCenter(zone: Zone): [number, number] {
  const ring = zone.geometry.coordinates[0] ?? []
  const lons = ring.map(([lon]) => lon)
  const lats = ring.map(([, lat]) => lat)
  return [(Math.min(...lats) + Math.max(...lats)) / 2, (Math.min(...lons) + Math.max(...lons)) / 2]
}

// Todo el planeta en coordenadas [lat, lon].
const WORLD: L.LatLngBoundsExpression = [[-90, -180], [90, 180]]

// Leaflet mide el contenedor una sola vez al montarse. Si en ese momento el layout aún no
// tiene alto (grid, fuentes o panel cargando), el mapa queda como una franja y no dibuja las zonas.
// Esto vuelve a medir cada vez que el contenedor cambia de tamaño (también al rotar el móvil)
// y, la primera vez que hay tamaño real, encuadra el planeta completo para que ninguna zona
// quede fuera de la vista.
function AutoResize() {
  const map = useMap()
  useEffect(() => {
    let fitted = false
    const observer = new ResizeObserver(() => {
      map.invalidateSize()
      const { x, y } = map.getSize()
      if (!fitted && x > 0 && y > 0) {
        map.fitBounds(WORLD, { animate: false })
        fitted = true
      }
    })
    observer.observe(map.getContainer())
    return () => observer.disconnect()
  }, [map])
  return null
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
      minZoom={-1}                  // en móvil el planeta completo (512 px a zoom 0) no entra sin alejar más
      maxZoom={layer.maxZoom}
      zoomSnap={0.25}               // permite encuadrar el planeta sin saltos de zoom enteros
      maxBounds={WORLD}             // no deja arrastrar el mapa fuera del planeta
      maxBoundsViscosity={1}
      worldCopyJump={false}
    >
      <AutoResize />
      <TileLayer url={layer.url} attribution={layer.attribution} noWrap bounds={WORLD} tileSize={256}
        minZoom={-1} minNativeZoom={0} />
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
      {/* Punto de tamaño fijo en el centro de cada zona: a zoom bajo muchas zonas miden
          pocos píxeles (Jezero ~2 px en móvil) y no se pueden tocar con el dedo. */}
      {zones?.map((z) => (
        <CircleMarker
          key={`${z.id}-${z.id === selectedId}`}
          center={zoneCenter(z)}
          radius={z.id === selectedId ? 9 : 7}
          pathOptions={z.id === selectedId ? markerSelectedStyle : markerStyle}
          eventHandlers={{ click: () => onSelect(z) }}
        >
          <Tooltip>{z.name}</Tooltip>
        </CircleMarker>
      ))}
    </MapContainer>
  )
}
