"
I export bloc elements as PDF file.

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
	#name : #BlPdfExporter,
	#superclass : #BlFileExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #accessing }
BlPdfExporter >> extension [

	^ 'pdf'
]

{ #category : #private }
BlPdfExporter >> finishExport: aCanvas [
	"Answer a file reference to the exported PDF."

	aCanvas
		flush;
		finish.
	^ self target
]

{ #category : #private }
BlPdfExporter >> newCanvas: anExtent [

	| aSurface |
	aSurface := AeCairoPDFSurface
		            extent: anExtent
		            to: self target.

	^ AeCanvas newFor: aSurface
]
