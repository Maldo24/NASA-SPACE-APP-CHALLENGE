import { useI18n } from '../i18n/I18nProvider'
import type { AnalogRecognition } from '../types/domain'

// Etiqueta "Ya conocido" / "Propuesto". No muestra nada si el análogo está pendiente de clasificar.
export default function RecognitionBadge({ value }: { value: AnalogRecognition | null }) {
  const { t } = useI18n()
  if (!value) return null
  const hint = value === 'known' ? t.recognition.knownHint : t.recognition.proposedHint
  return (
    <span className={`recognition-badge recognition-${value}`} title={hint}>
      {t.recognition[value]}
    </span>
  )
}
