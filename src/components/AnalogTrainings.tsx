// Entrenamientos posibles en el análogo (tarea 3, datos: Sebastián).
// Datos: supabase/seed/08_entrenamientos.sql (y 09 para análogos nuevos).
import type { AnalogTraining, TrainingAudience } from '../types/domain'

const AUDIENCE_LABEL: Record<TrainingAudience, string> = {
  astronauts: 'Astronautas',
  rovers: 'Rovers',
  suits: 'Trajes',
  habitats: 'Hábitats',
  science: 'Ciencia',
}

export default function AnalogTrainings({ trainings }: { trainings: AnalogTraining[] }) {
  if (trainings.length === 0) {
    return <p className="detail-pending">Entrenamiento posible: pendiente.</p>
  }

  return (
    <details className="analog-detail">
      <summary>Entrenamiento posible ({trainings.length})</summary>
      <ul className="training-list">
        {trainings.map((t, i) => (
          <li key={i}>
            <span className="training-audience">{AUDIENCE_LABEL[t.audience]}</span>
            <p>{t.activity}</p>
            <p><strong>Se mide:</strong> {t.measures}</p>
            {t.restrictions && <p><strong>Restricciones:</strong> {t.restrictions}</p>}
            {t.source && (
              <a className="detail-source" href={t.source} target="_blank" rel="noopener noreferrer">
                Fuente <span aria-hidden="true">↗</span>
              </a>
            )}
          </li>
        ))}
      </ul>
    </details>
  )
}
