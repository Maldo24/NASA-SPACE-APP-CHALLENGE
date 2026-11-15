// Idioma de la app (español o inglés), sin depender de la traducción automática del navegador.
//
// Idioma inicial, en este orden:
//   1. ?lang=en o ?lang=es en la URL (para compartir un enlace en un idioma concreto)
//   2. la última elección guardada en este navegador
//   3. el idioma del navegador (español -> es; cualquier otro -> en)
import { createContext, useCallback, useContext, useEffect, useMemo, useState, type ReactNode } from 'react'
import { STRINGS, type UiStrings } from './strings'

export type Lang = 'es' | 'en'
export const LANGS: readonly Lang[] = ['es', 'en']

const STORAGE_KEY = 'pacha-x-lang'
const isLang = (value: unknown): value is Lang => value === 'es' || value === 'en'

function initialLang(): Lang {
  try {
    const fromUrl = new URLSearchParams(window.location.search).get('lang')
    if (isLang(fromUrl)) return fromUrl
  } catch { /* sin URL válida: se sigue con lo demás */ }
  try {
    const saved = window.localStorage.getItem(STORAGE_KEY)
    if (isLang(saved)) return saved
  } catch { /* almacenamiento bloqueado (modo privado): se ignora */ }
  const browser = navigator.languages?.length ? navigator.languages : [navigator.language]
  return browser.some((l) => l?.toLowerCase().startsWith('es')) ? 'es' : 'en'
}

interface I18nValue {
  lang: Lang
  setLang: (lang: Lang) => void
  /** Textos de la interfaz en el idioma actual. */
  t: UiStrings
}

const I18nContext = createContext<I18nValue | null>(null)

export function I18nProvider({ children }: { children: ReactNode }) {
  const [lang, setLangState] = useState<Lang>(initialLang)

  const setLang = useCallback((next: Lang) => {
    setLangState(next)
    try { window.localStorage.setItem(STORAGE_KEY, next) } catch { /* sin almacenamiento: solo dura esta visita */ }
  }, [])

  // Idioma del documento: lectores de pantalla, buscadores y corrector ortográfico.
  useEffect(() => { document.documentElement.lang = lang }, [lang])

  const value = useMemo(() => ({ lang, setLang, t: STRINGS[lang] }), [lang, setLang])
  return <I18nContext.Provider value={value}>{children}</I18nContext.Provider>
}

export function useI18n(): I18nValue {
  const value = useContext(I18nContext)
  if (!value) throw new Error('useI18n debe usarse dentro de <I18nProvider>')
  return value
}
