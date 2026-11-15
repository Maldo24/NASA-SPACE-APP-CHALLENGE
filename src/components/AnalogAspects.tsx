// Qué reproduce el análogo y dónde se rompe, por tipo de analogía (tarea 1, datos: Maldo).
// Datos: supabase/seed/06_limites.sql (y 09 para análogos nuevos).
// Se muestra en la página de detalle del análogo (AnalogDetailPage).
import { CATEGORIES, CATEGORY_KEYS } from '../config/categories'
import type { AnalogAspect } from '../types/domain'

export default function AnalogAspects({ aspects }: { aspects: AnalogAspect[] }) {
  const covered = new Set(aspects.map((a) => a.category))
  const notCovered = CATEGORY_KEYS.filter((c) => !covered.has(c))

  return (
    <section className="detail-section" aria-labelledby="aspects-heading">
      <h3 id="aspects-heading">Qué cubre y dónde se rompe</h3>
      {aspects.length === 0 ? (
        <p className="item-pending">Análisis por tipo de analogía: pendiente.</p>
      ) : <>
        <ul className="aspect-list">
          {aspects.map((a) => (
            <li key={a.category}>
              <p className="aspect-category">{CATEGORIES[a.category].label}</p>
              <p><span className="aspect-tag covers">Reproduce</span> {a.covers}</p>
              <p><span className="aspect-tag breaks">Se rompe</span> {a.breaks}</p>
              {a.source && (
                <a className="item-source" href={a.source} target="_blank" rel="noopener noreferrer">
                  Fuente <span aria-hidden="true">↗</span>
                  <span className="sr-only"> (abre en otra pestaña)</span>
                </a>
              )}
            </li>
          ))}
        </ul>
        {notCovered.length > 0 && (
          <p className="aspect-none">
            <strong>No cubre:</strong> {notCovered.map((c) => CATEGORIES[c].label).join(', ')}.
          </p>
        )}
      </>}
    </section>
  )
}
