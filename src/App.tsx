// Persona A. Rutas (/luna, /marte) y estado mínimo: la zona seleccionada.
import { useState } from 'react'
import { matchPath, Navigate, Route, Routes, useLocation, useNavigate } from 'react-router-dom'
import MoonMap from './components/maps/MoonMap.tsx'
import MarsMap from './components/maps/MarsMap.tsx'
import ZonePanel from './components/ZonePanel.tsx'
import AnalogDetailPage from './components/AnalogDetailPage.tsx'
import LanguageSwitch from './i18n/LanguageSwitch.tsx'
import { useI18n } from './i18n/I18nProvider.tsx'
import type { BodyId, Category, Zone } from './types/domain.ts'

const ROUTES: { body: BodyId; path: string }[] = [
  { body: 'moon', path: '/luna' },
  { body: 'mars', path: '/marte' },
]

export default function App() {
  const { t } = useI18n()
  const { pathname } = useLocation()
  const navigate = useNavigate()

  // La selección recuerda en qué ruta se hizo: al cambiar de mapa queda vacía sola.
  const [selection, setSelection] = useState<{ path: string; zone: Zone; category?: Category } | null>(null)
  const selectedZone = selection?.path === pathname ? selection.zone : null
  const select = (zone: Zone) => setSelection({ path: pathname, zone })
  const selectCategory = (category: Category) => {
    setSelection((current) => current ? { ...current, category } : current)
  }
  const returnToZone = (zone: Zone, category: Category) => {
    setSelection({ path: zone.bodyId === 'moon' ? '/luna' : '/marte', zone, category })
  }
  const isDetailPage = Boolean(
    matchPath('/luna/analogos/:zoneId/:analogId', pathname)
    || matchPath('/marte/analogos/:zoneId/:analogId', pathname),
  )

  const mapProps = { selectedId: selectedZone?.id, onSelect: select }

  return (
    <div className="app">
      <header className="topbar">
        <h1>Pacha-X</h1>
        <div className="topbar-controls">
        <nav className="switcher" aria-label={t.bodies.nav}>
          {ROUTES.map((r) => (
            <button
              key={r.path}
              className={pathname === r.path || pathname.startsWith(`${r.path}/`) ? 'active' : ''}
              aria-current={pathname === r.path || pathname.startsWith(`${r.path}/`) ? 'page' : undefined}
              onClick={() => navigate(r.path)}
            >
              {t.bodies[r.body]}
            </button>
          ))}
        </nav>
        <LanguageSwitch />
        </div>
      </header>
      <main className={isDetailPage ? 'analog-detail-layout' : 'layout'}>
        <Routes>
          <Route path="/luna" element={<MoonMap {...mapProps} />} />
          <Route path="/marte" element={<MarsMap {...mapProps} />} />
          <Route path="/luna/analogos/:zoneId/:analogId" element={<AnalogDetailPage bodyId="moon" onReturnToZone={returnToZone} />} />
          <Route path="/marte/analogos/:zoneId/:analogId" element={<AnalogDetailPage bodyId="mars" onReturnToZone={returnToZone} />} />
          <Route path="*" element={<Navigate to="/luna" replace />} />
        </Routes>
        {!isDetailPage && <ZonePanel zone={selectedZone} initialCategory={selection?.category} onCategoryChange={selectCategory} />}
      </main>
    </div>
  )
}
