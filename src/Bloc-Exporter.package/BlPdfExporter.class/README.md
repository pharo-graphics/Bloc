I export bloc elements as PDF file.

[[[
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipse new.
element size: 400@200.

(BlExporter pdf element: element; fileName: 'test.pdf'; export) inspect
]]]