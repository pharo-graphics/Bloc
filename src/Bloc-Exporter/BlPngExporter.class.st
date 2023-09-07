"
I export bloc elements as PNG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter png
	element: element;
	target: 'test.png' asFileReference;
	export) inspect
```

"
Class {
	#name : #BlPngExporter,
	#superclass : #BlFileExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #accessing }
BlPngExporter >> extension [

	^ 'png'
]

{ #category : #private }
BlPngExporter >> finishExport: aCanvas [
	"Answer a file reference to the exported PNG."

	self target ensureDelete.

	aCanvas writePngTo: self target.

	^ self target
]

{ #category : #private }
BlPngExporter >> newCanvas: anExtent [

	^ AeCanvas extent: anExtent
]
