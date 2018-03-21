I export bloc elements as PNG file.

[[[
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipse new.
element size: 400@200.

(BlExporter png element: element; fileName: 'test.png'; export) inspect
]]]