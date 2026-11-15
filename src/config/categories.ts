// Las 4 categorías de analogía, en orden. Los nombres y descripciones, en los dos idiomas,
// están en src/i18n/strings.ts (t.categories[categoría]).
export const CATEGORIES = {
  geomorphological: { number: '01' },
  mineralogical: { number: '02' },
  environmental: { number: '03' },
  operational: { number: '04' },
} as const

export type Category = keyof typeof CATEGORIES
export const CATEGORY_KEYS = Object.keys(CATEGORIES) as Category[]
