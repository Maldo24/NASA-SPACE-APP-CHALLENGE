// Estado global mínimo: cuerpo, zona seleccionada, categoría activa.
import { useState } from 'react'
import BodySwitcher from './components/BodySwitcher.jsx'
import PlanetMap from './components/PlanetMap.jsx'
import ZonePanel from './components/ZonePanel.jsx'
import { getZones } from './lib/data.js'

export default function App() {
  const [body, setBody] = useState('moon')           // 'moon' | 'mars'
  const [selectedZone, setSelectedZone] = useState(null)

  const changeBody = (b) => { setBody(b); setSelectedZone(null) }

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
