// Entrenamientos posibles en el análogo (tarea 3, datos: Miguel).
// Datos: supabase/seed/08_entrenamientos.sql (y 09 para análogos nuevos).
// Se muestra en la página de detalle del análogo (AnalogDetailPage).
import type { AnalogTraining, TrainingAudience } from '../types/domain'

const AUDIENCE_LABEL: Record<TrainingAudience, string> = {
  astronauts: 'Astronautas',
  rovers: 'Rovers',
  suits: 'Trajes',
  habitats: 'Hábitats',
  science: 'Ciencia',
}

export default function AnalogTrainings({ trainings }: { trainings: AnalogTraining[] }) {
  return (
    <section className="detail-section" aria-labelledby="trainings-heading">
      <h3 id="trainings-heading">Entrenamiento posible</h3>
      {trainings.length === 0 ? (
        <p className="item-pending">Entrenamiento posible: pendiente.</p>
      ) : (
        <ul className="training-list">
          {trainings.map((t, i) => (
            <li key={i}>
              <span className="training-audience">{AUDIENCE_LABEL[t.audience]}</span>
              <p>{t.activity}</p>
              <p><strong>Se mide:</strong> {t.measures}</p>
              {t.restrictions && <p><strong>Restricciones:</strong> {t.restrictions}</p>}
              {t.source && (
                <a className="item-source" href={t.source} target="_blank" rel="noopener noreferrer">
                  Fuente <span aria-hidden="true">↗</span>
                  <span className="sr-only"> (abre en otra pestaña)</span>
                </a>
              )}
            </li>
          ))}
        </ul>
      )}
    </section>
  )
}
