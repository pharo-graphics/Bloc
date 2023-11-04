"
I export bloc elements as PNG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BAExporter png
	element: element;
	target: 'test.png' asFileReference;
	export) inspect
```

"
Class {
	#name : 'BAPngExporter',
	#superclass : 'BAFileExporter',
	#category : 'Bloc-Alexandrie-Exporter',
	#package : 'Bloc-Alexandrie-Exporter'
}

{ #category : 'accessing' }
BAPngExporter >> extension [

	^ 'png'
]

{ #category : 'private' }
BAPngExporter >> finishExport: aCanvas [
	"Answer a file reference to the exported PNG."

	self target ensureDelete.

	aCanvas writePngTo: self target.

	^ self target
]

{ #category : 'private' }
BAPngExporter >> newCanvas: anExtent [

	^ AeCanvas extent: anExtent
]
