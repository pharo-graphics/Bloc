I export bloc elements as SVG file.

[[[
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipse new.
element size: 400@200.

(BlExporter svg element: element; fileName: 'test.svg'; export) inspect
]]]