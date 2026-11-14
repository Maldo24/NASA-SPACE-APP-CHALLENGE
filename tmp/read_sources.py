from pathlib import Path
import json
import pdfplumber
from docx import Document

root = Path('C:/Users/santy/Downloads')
out = Path('D:/magios/tmp/lectura')
out.mkdir(parents=True, exist_ok=True)
names = ['Analogos_Marcianos_Bolivia_Entrenamiento_Rovers.pdf', 'Trajes espaciales composición por misión (ISS, Luna, Marte).pdf', 'Analogos_de_Marte_Bolivia_Latinoamerica_Mundo.pdf', 'Marte_topografia_y_analogos_terrestres.pdf']
for i, name in enumerate(names, 2):
    with pdfplumber.open(root / name) as pdf:
        pages = [p.extract_text() or '' for p in pdf.pages]
        (out / f'F{i}.txt').write_text('\n\n'.join(f'--- Página {n} ---\n{t}' for n, t in enumerate(pages, 1)), encoding='utf-8')
        print(json.dumps({'id': f'F{i}', 'name': name, 'pages': len(pages), 'chars': [len(t) for t in pages], 'images': [len(p.images) for p in pdf.pages]}, ensure_ascii=True))
doc = Document(root / 'Base_Lunar_Polo_Sur.docx')
from docx.oxml.ns import qn
text = '\n'.join(''.join(p.itertext()) for p in [])
paragraphs = [''.join(p.itertext()) for p in []]
paragraphs = [''.join(t.text or '' for t in p.iter(qn('w:t'))) for p in doc.element.body.iter(qn('w:p'))]
(out / 'F1.txt').write_text('\n'.join(paragraphs), encoding='utf-8')
print(json.dumps({'id': 'F1', 'paragraphs': len(paragraphs), 'inline_shapes': len(doc.inline_shapes)}))
