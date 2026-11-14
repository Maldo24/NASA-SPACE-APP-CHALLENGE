// Persona A. Rutas (/luna, /marte) y estado mínimo: la zona seleccionada.
import { useState } from 'react'
import { Navigate, Route, Routes, useLocation, useNavigate } from 'react-router-dom'
import MoonMap from './components/maps/MoonMap.tsx'
import MarsMap from './components/maps/MarsMap.tsx'
import ZonePanel from './components/ZonePanel.jsx'
import { LAYERS } from './config/layers.ts'
import type { BodyId, Zone } from './types/domain.ts'

const ROUTES: { body: BodyId; path: string }[] = [
  { body: 'moon', path: '/luna' },
  { body: 'mars', path: '/marte' },
]

export default function App() {
  const { pathname } = useLocation()
  const navigate = useNavigate()

  // La selección recuerda en qué ruta se hizo: al cambiar de mapa queda vacía sola.
  const [selection, setSelection] = useState<{ path: string; zone: Zone } | null>(null)
  const selectedZone = selection?.path === pathname ? selection.zone : null
  const select = (zone: Zone) => setSelection({ path: pathname, zone })

  const mapProps = { selectedId: selectedZone?.id, onSelect: select }

  return (
    <div className="app">
      <header className="topbar">
        <h1>Análogos Planetarios</h1>
        <nav className="switcher" aria-label="Cuerpo celeste">
          {ROUTES.map((r) => (
            <button
              key={r.path}
              className={pathname === r.path ? 'active' : ''}
              aria-current={pathname === r.path ? 'page' : undefined}
              onClick={() => navigate(r.path)}
            >
              {LAYERS[r.body].name}
            </button>
          ))}
        </nav>
      </header>
      <main className="layout">
        <Routes>
          <Route path="/luna" element={<MoonMap {...mapProps} />} />
          <Route path="/marte" element={<MarsMap {...mapProps} />} />
          <Route path="*" element={<Navigate to="/luna" replace />} />
        </Routes>
        <ZonePanel zone={selectedZone} />
      </main>
    </div>
  )
}
