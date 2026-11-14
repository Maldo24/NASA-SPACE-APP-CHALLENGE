/// <reference types="vite/client" />

// Variables de entorno que lee la app. Van en .env.local (no se sube) y en el panel de Vercel.
interface ImportMetaEnv {
  readonly VITE_SUPABASE_URL?: string
  readonly VITE_SUPABASE_ANON_KEY?: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
