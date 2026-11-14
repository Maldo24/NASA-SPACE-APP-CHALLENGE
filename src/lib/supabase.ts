// Persona A. Cliente de Supabase. Solo src/lib/ lo usa; los componentes nunca.
//
// Usa la clave `anon` (pública): el RLS del esquema solo permite LEER.
// Nunca pongas aquí la `service_role`.
//
// Si faltan VITE_SUPABASE_URL o VITE_SUPABASE_ANON_KEY, el cliente es null
// y lib/data.ts usa la semilla JSON. Así la app funciona sin credenciales.
import { createClient, type SupabaseClient } from '@supabase/supabase-js'

const url = import.meta.env.VITE_SUPABASE_URL
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabase: SupabaseClient | null =
  url && anonKey
    ? createClient(url, anonKey, { auth: { persistSession: false } }) // la app no tiene login
    : null
