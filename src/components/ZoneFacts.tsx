// Ficha completa de una zona de la Luna o de Marte (tarea 2, datos: Santiago).
// Datos: supabase/seed/07_zonas.sql.
import type { Zone } from '../types/domain'

const SECTIONS = [
  ['geology', 'Geología'],
  ['environment', 'Ambiente'],
  ['exploration', 'Exploración'],
  ['importance', 'Por qué interesa'],
] as const

export default function ZoneFacts({ zone }: { zone: Zone }) {
  const filled = SECTIONS.filter(([key]) => zone[key])

  if (filled.length === 0 && zone.sources.length === 0) {
    return <p className="item-pending">Ficha detallada de la zona: pendiente.</p>
  }

  return (
    <details className="zone-facts">
      <summary>Ficha de la zona</summary>
      <dl>
        {filled.map(([key, label]) => (
          <div key={key}>
            <dt>{label}</dt>
            <dd>{zone[key]}</dd>
          </div>
        ))}
      </dl>
      {zone.sources.length > 0 && (
        <p className="zone-facts-sources">
          Fuentes:{' '}
          {zone.sources.map((url, i) => (
            <a key={url} href={url} target="_blank" rel="noopener noreferrer">
              [{i + 1}]<span className="sr-only"> (abre en otra pestaña)</span>
            </a>
          ))}
        </p>
      )}
    </details>
  )
}
