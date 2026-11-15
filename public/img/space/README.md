# Fondo espacial

## Tierra animada y Sol

- `earth-blue-marble.jpg`: textura equirectangular Blue Marble, NASA Goddard Space Flight Center; Reto Stöckli y Robert Simmon. Copia sin cambios de https://commons.wikimedia.org/wiki/File:Land_ocean_ice_2048.jpg, bajo CC BY-SA 3.0: https://creativecommons.org/licenses/by-sa/3.0/ . El archivo mantiene esa licencia. La proyección esférica, rotación y sombreado se calculan durante la visualización.
- `solar-grain.svg`: textura procedural creada para Pacha-X; no es una fotografía solar.

La Tierra se proyecta sobre una esfera con eje inclinado y luz desde la dirección visual del Sol. Su rotación y desplazamiento elíptico son decorativos y acelerados, sin distancias, órbitas ni periodos astronómicos a escala. El Sol tiene disco, granulación y corona estilizados; las estrellas lejanas aportan profundidad. No se representan otros planetas junto a Marte.

Con `prefers-reduced-motion: reduce` se muestra una composición estática. La rotación se suspende al ocultar la pestaña y se liberan sus recursos al cambiar de vista. Sin WebGL o si no carga la textura, queda la fotografía local original como respaldo.

- `stars.svg`: campo de estrellas decorativo generado para Pacha-X; no es un mapa astronómico.
- `earth-apollo17.jpg`: NASA / tripulación del Apolo 17, AS17-148-22727. Fuente: https://www.nasa.gov/image-article/apollo-17-blue-marble/
  Archivo: https://www.nasa.gov/wp-content/uploads/2023/03/as17-148-22727_lrg.jpg?resize=600,600

La Tierra es un elemento decorativo de la vista lunar. Su tamaño, iluminación y posición no representan una simulación astronómica.
