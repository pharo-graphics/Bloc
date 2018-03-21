I export bloc elements as JPG file.

[[[
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipse new.
element size: 400@200.

(BlExporter jpg element: element; fileName: 'test.jpg'; export) inspect
]]]