import React from 'react'
import ReactDOM from 'react-dom/client'
import 'leaflet/dist/leaflet.css'
import './App.css'
import App from './App.tsx'

const root = document.getElementById('root')
if (!root) throw new Error('No se encontró el elemento #root en index.html')

ReactDOM.createRoot(root).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
