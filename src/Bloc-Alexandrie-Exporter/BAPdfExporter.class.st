"
I export bloc elements as PDF file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BAExporter pdf
	element: element;
	target: 'test.pdf' asFileReference;
	export) inspect
```

"
Class {
	#name : 'BAPdfExporter',
	#superclass : 'BAFileExporter',
	#category : 'Bloc-Alexandrie-Exporter',
	#package : 'Bloc-Alexandrie-Exporter'
}

{ #category : 'accessing' }
BAPdfExporter >> extension [

	^ 'pdf'
]

{ #category : 'private' }
BAPdfExporter >> finishExport: aCanvas [
	"Answer a file reference to the exported PDF."

	aCanvas
		flush;
		finish.
	^ self target
]

{ #category : 'private' }
BAPdfExporter >> newCanvas: anExtent [

	| aSurface |
	aSurface := AeCairoPDFSurface
		            extent: anExtent
		            to: self target.

	^ AeCanvas newFor: aSurface
]
