import { useRef, type KeyboardEvent } from 'react'
import { CATEGORIES, CATEGORY_KEYS, type Category } from '../config/categories'
import { useI18n } from '../i18n/I18nProvider'
import type { GroupedAnalogs } from './ui-types'

interface CategoryTabsProps {
  active: Category
  counts: GroupedAnalogs
  onChange: (category: Category) => void
  idPrefix: string
}

export default function CategoryTabs({ active, counts, onChange, idPrefix }: CategoryTabsProps) {
  const { t } = useI18n()
  const buttons = useRef<Partial<Record<Category, HTMLButtonElement | null>>>({})

  function handleKeyDown(event: KeyboardEvent<HTMLButtonElement>, category: Category) {
    const index = CATEGORY_KEYS.indexOf(category)
    let next: number
    switch (event.key) {
      case 'ArrowRight': next = (index + 1) % CATEGORY_KEYS.length; break
      case 'ArrowLeft': next = (index + CATEGORY_KEYS.length - 1) % CATEGORY_KEYS.length; break
      case 'Home': next = 0; break
      case 'End': next = CATEGORY_KEYS.length - 1; break
      default: return
    }
    event.preventDefault()
    const nextCategory = CATEGORY_KEYS[next]!
    onChange(nextCategory)
    buttons.current[nextCategory]?.focus()
  }

  return (
    <div className="tabs" role="tablist" aria-label={t.panel.tabsLabel}>
      {CATEGORY_KEYS.map((category) => {
        const count = counts[category]?.length ?? 0
        return (
          <button
            key={category}
            ref={(element) => { buttons.current[category] = element }}
            id={`${idPrefix}-tab-${category}`}
            type="button" role="tab"
            aria-selected={category === active}
            aria-controls={`${idPrefix}-panel-${category}`}
            aria-label={t.panel.tabLabel(t.categories[category].label, count)}
            tabIndex={category === active ? 0 : -1}
            className={category === active ? 'active' : ''}
            onClick={() => onChange(category)}
            onKeyDown={(event) => handleKeyDown(event, category)}
          >
            <span className="tab-number" aria-hidden="true">{CATEGORIES[category].number}</span>
            <span>{t.categories[category].short}</span>
            <span className="tab-count" aria-hidden="true">{count}</span>
          </button>
        )
      })}
    </div>
  )
}
