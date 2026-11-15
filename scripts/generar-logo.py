# Genera los archivos del logo de Pacha-X a partir de la geometría ajustada al PNG original.
# Uso (desde la raíz del repo): python3 scripts/generar-logo.py public
# Necesita Pillow. Regenera favicon.svg, los PNG de íconos, og-image.png y brand/pacha-x-logo.svg.
import sys, os
from PIL import Image, ImageDraw, ImageFont

PUB = sys.argv[1]
NAVY, LIGHT, PAPER = '#0b1f3a', '#edf1f3', '#f7f7f7'

# Geometría (unidades del PNG de 256 px): 9 rombos + agujero + estrella de 4 puntas.
XS, YS, D = (88, 116, 144), (112, 140, 168), 27.25
HOLE = (116, 140, 16.25)
STAR = [(212, 12), (219, 36.75), (243.75, 43.75), (219, 50.75), (212, 75.5), (205, 50.75), (180.25, 43.75), (205, 36.75)]
VB = (56, 8, 192, 192)  # caja que contiene el dibujo con un margen de ~4

def fmt(v): return f'{v:g}'
# El cuadrado central cierra los 4 huecos diminutos donde se tocan las puntas de los rombos.
diamonds = 'M88 112h56v56h-56z ' + ' '.join(f'M{fmt(x)} {fmt(y - D)}l{fmt(D)} {fmt(D)}l-{fmt(D)} {fmt(D)}l-{fmt(D)} -{fmt(D)}z' for x in XS for y in YS)
star = 'M' + 'L'.join(f'{fmt(x)} {fmt(y)}' for x, y in STAR) + 'Z'
hx, hy, hr = HOLE

def svg(fill_css, extra_style=''):
    return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="{' '.join(map(fmt, VB))}">
  <title>Pacha-X</title>
  <style>.f{{fill:{fill_css}}}{extra_style}</style>
  <mask id="h"><rect x="0" y="0" width="256" height="256" fill="#fff"/><circle cx="{fmt(hx)}" cy="{fmt(hy)}" r="{fmt(hr)}" fill="#000"/></mask>
  <path class="f" mask="url(#h)" d="{diamonds}"/>
  <path class="f" d="{star}"/>
</svg>
'''

os.makedirs(f'{PUB}/brand', exist_ok=True)
open(f'{PUB}/brand/pacha-x-logo.svg', 'w').write(svg(NAVY))
# Favicon: azul en pestañas claras y claro en pestañas oscuras.
open(f'{PUB}/favicon.svg', 'w').write(svg(NAVY, f'@media (prefers-color-scheme:dark){{.f{{fill:{LIGHT}}}}}'))

def draw_mark(img, box, color):
    """Dibuja el símbolo dentro de box=(x, y, lado) con supermuestreo."""
    bx, by, side = box
    S = 4
    layer = Image.new('L', (int(side * S), int(side * S)), 0); g = ImageDraw.Draw(layer)
    k = side * S / VB[2]
    T = lambda x, y: ((x - VB[0]) * k, (y - VB[1]) * k)
    for x in XS:
        for y in YS:
            g.polygon([T(x, y - D), T(x + D, y), T(x, y + D), T(x - D, y)], fill=255)
    g.polygon([T(88, 112), T(144, 112), T(144, 168), T(88, 168)], fill=255)
    (cx, cy), r = T(hx, hy), hr * k
    g.ellipse([cx - r, cy - r, cx + r, cy + r], fill=0)
    g.polygon([T(x, y) for x, y in STAR], fill=255)
    layer = layer.resize((int(side), int(side)), Image.LANCZOS)
    img.paste(Image.new('RGBA', layer.size, color), (int(bx), int(by)), layer)

def icon(size, pad, bg):
    img = Image.new('RGBA', (size, size), bg or (0, 0, 0, 0))
    draw_mark(img, (pad, pad, size - 2 * pad), NAVY)
    return img

icon(32, 3, PAPER).save(f'{PUB}/favicon-32.png')
icon(180, 26, PAPER).convert('RGB').save(f'{PUB}/apple-touch-icon.png')
icon(192, 28, PAPER).save(f'{PUB}/icon-192.png')
icon(512, 74, PAPER).save(f'{PUB}/icon-512.png')
# Versión "maskable" para Android: el dibujo dentro de la zona segura (80 % central).
icon(512, 112, PAPER).save(f'{PUB}/icon-maskable-512.png')

# Imagen para compartir el enlace (WhatsApp, redes): logo horizontal sobre fondo claro.
og = Image.new('RGB', (1200, 630), PAPER)
font = ImageFont.truetype('/usr/share/fonts/liberation-sans-fonts/LiberationSans-Regular.ttf', 100)
g = ImageDraw.Draw(og)
TRACK, MARK, GAP = 30, 210, 64
text_w = sum(g.textlength(ch, font=font) for ch in 'PACHA-X') + TRACK * 6
x0 = (1200 - (MARK + GAP + text_w)) / 2
draw_mark(og, (x0, 315 - MARK / 2, MARK), NAVY)
cap = font.getbbox('H', anchor='ls')[1]  # altura de mayúscula (negativa)
x = x0 + MARK + GAP
for ch in 'PACHA-X':
    g.text((x, 315 - cap / 2), ch, font=font, fill=NAVY, anchor='ls')
    x += g.textlength(ch, font=font) + TRACK
og.save(f'{PUB}/og-image.png', optimize=True)
print('ok', round(x0), round(x))
