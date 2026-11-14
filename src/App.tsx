// Estado global mínimo: cuerpo y zona seleccionada.
// Paso 1 de la migración a TypeScript: misma lógica que App.jsx.
// Las rutas /luna y /marte llegan en el paso 2.
import { useState } from 'react'
import BodySwitcher from './components/BodySwitcher.jsx'
import PlanetMap from './components/PlanetMap.jsx'
import ZonePanel from './components/ZonePanel.jsx'
import { getZones } from './lib/data.js'

type BodyId = 'moon' | 'mars'

// Mínimo necesario hasta que exista types/domain.ts (persona C).
type ZoneFeature = { properties: { id: string } }

export default function App() {
  const [body, setBody] = useState<BodyId>('moon')
  const [selectedZone, setSelectedZone] = useState<ZoneFeature | null>(null)

  const changeBody = (b: BodyId) => { setBody(b); setSelectedZone(null) }

  return (
    <div className="app">
      <header className="topbar">
        <h1>Análogos Planetarios</h1>
        <BodySwitcher body={body} onChange={changeBody} />
      </header>
      <main className="layout">
        <PlanetMap
          key={body}                     // remonta el mapa al cambiar de cuerpo
          body={body}
          zones={getZones(body)}
          selectedId={selectedZone?.properties.id}
          onSelect={setSelectedZone}
        />
        <ZonePanel zone={selectedZone} />
      </main>
    </div>
  )
}
