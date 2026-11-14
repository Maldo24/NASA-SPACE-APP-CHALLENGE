// Persona 1. Botones Luna / Marte.
import { LAYERS } from '../config/layers.js'

export default function BodySwitcher({ body, onChange }) {
  return (
    <div className="switcher">
      {Object.entries(LAYERS).map(([key, l]) => (
        <button key={key} className={key === body ? 'active' : ''} onClick={() => onChange(key)}>
          {l.name}
        </button>
      ))}
    </div>
  )
}
