// Botón para cambiar el idioma de la app (ES / EN).
import { LANGS, useI18n } from './I18nProvider'

export default function LanguageSwitch() {
  const { lang, setLang, t } = useI18n()
  return (
    <div className="switcher lang-switch" role="group" aria-label={t.langSwitch.group}>
      {LANGS.map((l) => (
        <button
          key={l}
          type="button"
          lang={l}
          className={l === lang ? 'active' : ''}
          aria-pressed={l === lang}
          aria-label={t.langSwitch[l]}
          title={t.langSwitch[l]}
          onClick={() => setLang(l)}
        >
          {l.toUpperCase()}
        </button>
      ))}
    </div>
  )
}
