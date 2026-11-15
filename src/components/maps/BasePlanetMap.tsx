// Persona A. Globo 3D común para la Luna y Marte (antes era un mapa plano de Leaflet).
// MoonMap y MarsMap solo eligen el cuerpo; todo lo demás vive aquí.
import { lazy, Suspense, useEffect, useMemo, useRef, useState } from 'react'
import type { GlobeMethods } from 'react-globe.gl'
import { LAYERS } from '../../config/layers.ts'
import { getZones } from '../../lib/data.ts'
import { planetTexture } from '../../lib/planetTexture.ts'
import type { BodyId, Zone } from '../../types/domain.ts'

// La librería del globo (three.js incluido) pesa casi 2 MB: se baja aparte, después de la página.
const Globe = lazy(() => import('react-globe.gl'))

export type PlanetMapProps = {
  selectedId?: string
  onSelect: (zone: Zone) => void
}

// Aspecto de cada cuerpo en el globo.
const LOOK: Record<BodyId, { atmosphere: string | null }> = {
  moon: { atmosphere: null },        // la Luna no tiene atmósfera
  mars: { atmosphere: '#e08a5c' },   // halo rojizo, delgado como su atmósfera
}

const ALT_START = 2.4   // distancia inicial de la cámara, en radios del planeta
const ALT_ZONE = 1.5    // distancia al enfocar una zona

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

// Textura del planeta armada con los tiles de Trek. null = cargando o falló.
function useTexture(body: BodyId) {
  const [url, setUrl] = useState<string | null>(null)
  useEffect(() => {
    let alive = true
    setUrl(null)
    planetTexture(LAYERS[body].url)
      .then((u) => { if (alive) setUrl(u) })
      .catch((err) => console.error(`No se pudo armar la textura de ${body}`, err))
    return () => { alive = false }
  }, [body])
  return url
}

// Tamaño del contenedor: el globo es un canvas WebGL y necesita ancho y alto en píxeles.
function useSize<T extends HTMLElement>() {
  const ref = useRef<T>(null)
  const [size, setSize] = useState({ width: 0, height: 0 })
  useEffect(() => {
    const el = ref.current
    if (!el) return
    const observer = new ResizeObserver(([entry]) => {
      const { width, height } = entry.contentRect
      setSize({ width: Math.round(width), height: Math.round(height) })
    })
    observer.observe(el)
    return () => observer.disconnect()
  }, [])
  return [ref, size] as const
}

// Centro del rectángulo que envuelve la zona (la geometría guarda [lon, lat]).
function zoneCenter(zone: Zone): { lat: number; lng: number } {
  const ring = zone.geometry.coordinates[0] ?? []
  const lons = ring.map(([lon]) => lon)
  const lats = ring.map(([, lat]) => lat)
  return { lat: (Math.min(...lats) + Math.max(...lats)) / 2, lng: (Math.min(...lons) + Math.max(...lons)) / 2 }
}

type Marker = { zone: Zone; lat: number; lng: number }
type Ring = Zone['geometry']['coordinates'][number]

// El globo sigue la convención de d3-geo: el anillo exterior va en sentido horario. Con el sentido
// antihorario de GeoJSON (RFC 7946) pinta "todo el planeta menos la zona", así que se invierte.
function clockwise(ring: Ring): Ring {
  let area = 0
  for (let i = 0; i < ring.length - 1; i++) area += ring[i][0] * ring[i + 1][1] - ring[i + 1][0] * ring[i][1]
  return area > 0 ? [...ring].reverse() : ring
}
const globeGeometry = (zone: Zone) => ({ type: 'Polygon', coordinates: zone.geometry.coordinates.map(clockwise) })

export default function BasePlanetMap({ body, selectedId, onSelect }: PlanetMapProps & { body: BodyId }) {
  const layer = LAYERS[body]
  const look = LOOK[body]
  const zones = useZones(body)
  const texture = useTexture(body)
  const [wrapRef, size] = useSize<HTMLDivElement>()
  const globeRef = useRef<GlobeMethods | undefined>(undefined)
  const [ready, setReady] = useState(false)

  // Los marcadores HTML se crean una vez; el clic siempre llama al onSelect más reciente.
  const onSelectRef = useRef(onSelect)
  onSelectRef.current = onSelect

  const markers = useMemo<Marker[]>(() => (zones ?? []).map((z) => ({ zone: z, ...zoneCenter(z) })), [zones])

  // Cámara inicial y giro lento hasta que la persona toque el globo.
  useEffect(() => {
    const g = globeRef.current
    if (!ready || !g) return
    g.pointOfView({ lat: 10, lng: 0, altitude: ALT_START }, 0)
    const controls = g.controls()
    controls.autoRotate = !window.matchMedia('(prefers-reduced-motion: reduce)').matches
    controls.autoRotateSpeed = 0.35
    controls.minDistance = 101 * 1.15  // no deja atravesar la superficie (radio del globo = 100)
    controls.maxDistance = 100 * 5
    const stop = () => { controls.autoRotate = false }
    controls.addEventListener('start', stop)
    return () => controls.removeEventListener('start', stop)
  }, [ready])

  // Al elegir una zona (en el globo o desde la URL) la cámara vuela hasta ella.
  useEffect(() => {
    const g = globeRef.current
    const m = markers.find((x) => x.zone.id === selectedId)
    if (!ready || !g || !m) return
    g.controls().autoRotate = false
    g.pointOfView({ lat: m.lat, lng: m.lng, altitude: ALT_ZONE }, 1200)
  }, [ready, selectedId, markers])

  return (
    <div ref={wrapRef} className="planet-map planet-globe">
      {size.width > 0 && size.height > 0 && (
        <Suspense fallback={null}>
        <Globe
          ref={globeRef}
          width={size.width}
          height={size.height}
          backgroundColor="rgba(0,0,0,0)"
          globeImageUrl={texture}
          showAtmosphere={look.atmosphere !== null}
          atmosphereColor={look.atmosphere ?? undefined}
          atmosphereAltitude={0.12}
          showGraticules
          onGlobeReady={() => setReady(true)}
          // Contorno de cada zona, apenas levantado de la superficie.
          polygonsData={zones ?? []}
          // react-globe.gl tipa `coordinates` como number[] aunque acepta cualquier GeoJSON; de ahí el cast.
          polygonGeoJsonGeometry={(d) => globeGeometry(d as Zone) as unknown as { type: string; coordinates: number[] }}
          polygonCapColor={(d) => ((d as Zone).id === selectedId ? 'rgba(255,107,107,0.35)' : 'rgba(255,212,59,0.18)')}
          polygonSideColor={() => 'rgba(255,212,59,0.08)'}
          polygonStrokeColor={(d) => ((d as Zone).id === selectedId ? '#ff6b6b' : '#ffd43b')}
          polygonAltitude={(d) => ((d as Zone).id === selectedId ? 0.012 : 0.006)}
          polygonsTransitionDuration={300}
          polygonLabel={(d) => (d as Zone).name}
          onPolygonClick={(d) => onSelectRef.current(d as Zone)}
          // Punto de tamaño fijo en el centro de cada zona: algunas zonas miden pocos píxeles
          // vistas desde lejos y no se podrían tocar con el dedo.
          htmlElementsData={markers}
          htmlLat={(d) => (d as Marker).lat}
          htmlLng={(d) => (d as Marker).lng}
          htmlAltitude={0}
          htmlTransitionDuration={0}
          htmlElement={(d) => {
            const { zone } = d as Marker
            const el = document.createElement('button')
            el.type = 'button'
            el.className = `globe-marker${zone.id === selectedId ? ' is-selected' : ''}`
            el.title = zone.name
            el.setAttribute('aria-label', zone.name)
            el.addEventListener('click', () => onSelectRef.current(zone))
            return el
          }}
          // Esconde los puntos del lado oculto del planeta.
          htmlElementVisibilityModifier={(el, visible) => { el.classList.toggle('is-hidden', !visible) }}
        />
        </Suspense>
      )}
      {(!texture || !ready) && <p className="globe-status">Cargando {layer.name.toLowerCase()}…</p>}
      <p className="globe-credit">{layer.attribution}</p>
    </div>
  )
}
