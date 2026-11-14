// Persona B. Panel lateral: info de la zona + análogos por categoría.
// Cambio mínimo de A (paso 3): `zone` ahora es un Zone de types/domain.ts y los análogos
// se cargan con getAnalogsForZone(zone.id), que es asíncrono y siempre trae las 4 categorías.
import { useEffect, useState } from 'react'
import CategoryTabs from './CategoryTabs.jsx'
import AnalogCard from './AnalogCard.jsx'
import { CATEGORIES } from '../config/categories.js'
import { emptyAnalogsByCategory, getAnalogsForZone } from '../lib/data.ts'

export default function ZonePanel({ zone }) {
  const [category, setCategory] = useState('geomorphological')
  const [grouped, setGrouped] = useState(null) // null = cargando
  const zoneId = zone?.id

  useEffect(() => {
    if (!zoneId) return
    let alive = true
    setGrouped(null)
    getAnalogsForZone(zoneId)
      .then((g) => { if (alive) setGrouped(g) })
      .catch((err) => {
        console.error(`No se pudieron cargar los análogos de ${zoneId}`, err)
        if (alive) setGrouped(emptyAnalogsByCategory())
      })
    return () => { alive = false }
  }, [zoneId])

  if (!zone) {
    return (
      <aside className="zone-panel">
        <p className="muted">Haz clic en una zona del mapa para ver sus análogos en la Tierra.</p>
      </aside>
    )
  }

  const list = grouped?.[category] ?? []

  return (
    <aside className="zone-panel">
      <h2>{zone.name}</h2>
      <p><strong>Tipo de zona:</strong> {zone.zoneType}</p>
      <p>{zone.description}</p>

      <CategoryTabs active={category} counts={grouped ?? emptyAnalogsByCategory()} onChange={setCategory} />
      <p className="muted">{CATEGORIES[category].description}</p>

      {grouped === null
        ? <p className="muted">Cargando análogos…</p>
        : list.length === 0
          ? <p className="muted">Sin análogos cargados para esta categoría.</p>
          : list.map((a) => <AnalogCard key={a.id} analog={a} />)}
    </aside>
  )
}
