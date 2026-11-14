// Persona 2. Panel lateral: info de la zona + análogos por categoría.
import { useState } from 'react'
import CategoryTabs from './CategoryTabs.jsx'
import AnalogCard from './AnalogCard.jsx'
import { CATEGORIES } from '../config/categories.js'
import { getAnalogsForZone } from '../lib/data.js'

export default function ZonePanel({ zone }) {
  const [category, setCategory] = useState('geomorphological')

  if (!zone) {
    return (
      <aside className="zone-panel">
        <p className="muted">Haz clic en una zona del mapa para ver sus análogos en la Tierra.</p>
      </aside>
    )
  }

  const p = zone.properties
  const grouped = getAnalogsForZone(zone)
  const list = grouped[category] ?? []

  return (
    <aside className="zone-panel">
      <h2>{p.name}</h2>
      <p><strong>Tipo de zona:</strong> {p.zoneType}</p>
      <p>{p.description}</p>

      <CategoryTabs active={category} counts={grouped} onChange={setCategory} />
      <p className="muted">{CATEGORIES[category].description}</p>

      {list.length === 0
        ? <p className="muted">Sin análogos cargados para esta categoría.</p>
        : list.map((a) => <AnalogCard key={a.id} analog={a} />)}
    </aside>
  )
}
