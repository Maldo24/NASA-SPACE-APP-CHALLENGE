import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// base '/' -> el deploy es en Vercel y hay rutas (/luna, /marte).
// Con './' los recursos fallan al abrir directamente una ruta.
export default defineConfig({
  plugins: [react()],
  base: '/',
})
