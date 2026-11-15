// Persona A. Rutas y zona seleccionada.
//
// Cada zona tiene su propia URL: /marte/jezero, /luna/shackleton, etc.
// La URL es la única fuente de la selección, así que el enlace se puede compartir,
// abrir directo (Vercel ya reescribe /luna/* y /marte/* a index.html) y el botón
// Atrás del navegador vuelve a la zona anterior.
import { useEffect, useState } from 'react'
import { Navigate, Route, Routes, useLocation, useNavigate, useParams } from 'react-router-dom'
import MoonMap from './components/maps/MoonMap.tsx'
import MarsMap from './components/maps/MarsMap.tsx'
import ZonePanel from './components/ZonePanel.tsx'
import { LAYERS } from './config/layers.ts'
import { getZone } from './lib/data.ts'
import type { BodyId, Zone } from './types/domain.ts'

const ROUTES: { body: BodyId; path: string }[] = [
  { body: 'moon', path: '/luna' },
  { body: 'mars', path: '/marte' },
]

// En la URL va el id sin el prefijo del cuerpo: 'mars-jezero' -> 'jezero'.
const slugOf = (zone: Zone) => zone.id.slice(zone.bodyId.length + 1)
const zoneIdOf = (body: BodyId, slug: string) => `${body}-${slug}`

const MAPS: Record<BodyId, typeof MoonMap> = { moon: MoonMap, mars: MarsMap }

// Zona que indica la URL. undefined = cargando, null = ninguna o no existe.
function useZoneFromUrl(body: BodyId, slug: string | undefined) {
  const [loaded, setLoaded] = useState<{ slug: string; zone: Zone | null } | null>(null)
  useEffect(() => {
    if (!slug) return
    let alive = true
    getZone(zoneIdOf(body, slug))
      .then((zone) => { if (alive) setLoaded({ slug, zone }) })
      .catch((err) => {
        console.error(`No se pudo cargar la zona ${slug}`, err)
        if (alive) setLoaded({ slug, zone: null })
      })
    return () => { alive = false }
  }, [body, slug])

  if (!slug) return null
  return loaded?.slug === slug ? loaded.zone : undefined
}

function BodyView({ body, basePath }: { body: BodyId; basePath: string }) {
  const { zoneSlug } = useParams()
  const navigate = useNavigate()
  const zone = useZoneFromUrl(body, zoneSlug)
  const BodyMap = MAPS[body]

  // Enlace a una zona que no existe (o de otro cuerpo): vuelve al mapa sin selección.
  if (zoneSlug && zone === null) return <Navigate to={basePath} replace />

  const selected = zone ?? null
  return (
    <>
      <BodyMap
        selectedId={selected?.id}
        onSelect={(z) => { if (z.id !== selected?.id) navigate(`${basePath}/${slugOf(z)}`) }}
      />
      <ZonePanel zone={selected} />
    </>
  )
}

export default function App() {
  const { pathname } = useLocation()
  const navigate = useNavigate()
  const isActive = (path: string) => pathname === path || pathname.startsWith(`${path}/`)

  return (
    <div className="app">
      <header className="topbar">
        <h1>Análogos Planetarios</h1>
        <nav className="switcher" aria-label="Cuerpo celeste">
          {ROUTES.map((r) => (
            <button
              key={r.path}
              className={isActive(r.path) ? 'active' : ''}
              aria-current={isActive(r.path) ? 'page' : undefined}
              onClick={() => navigate(r.path)}
            >
              {LAYERS[r.body].name}
            </button>
          ))}
        </nav>
      </header>
      <main className="layout">
        <Routes>
          {ROUTES.map((r) => (
            <Route
              key={r.body}
              path={`${r.path}/:zoneSlug?`}
              element={<BodyView key={r.body} body={r.body} basePath={r.path} />}
            />
          ))}
          <Route path="*" element={<Navigate to="/luna" replace />} />
        </Routes>
      </main>
    </div>
  )
}
