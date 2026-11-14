// Persona 2. Las 4 pestañas de categorías.
import { CATEGORIES, CATEGORY_KEYS } from '../config/categories.js'

export default function CategoryTabs({ active, counts, onChange }) {
  return (
    <div className="tabs">
      {CATEGORY_KEYS.map((key) => (
        <button key={key} className={key === active ? 'active' : ''} onClick={() => onChange(key)}>
          {CATEGORIES[key].label} ({counts[key]?.length ?? 0})
        </button>
      ))}
    </div>
  )
}
