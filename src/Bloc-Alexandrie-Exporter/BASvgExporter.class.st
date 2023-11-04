"
I export bloc elements as SVG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BAExporter svg
	element: element;
	target: 'test.svg' asFileReference;
	export) inspect
```
"
Class {
	#name : 'BASvgExporter',
	#superclass : 'BAFileExporter',
	#category : 'Bloc-Alexandrie-Exporter',
	#package : 'Bloc-Alexandrie-Exporter'
}

{ #category : 'accessing' }
BASvgExporter >> extension [

	^ 'svg'
]

{ #category : 'private' }
BASvgExporter >> finishExport: aCanvas [
	"Answer a file reference to the exported SVG."

	aCanvas
		flush;
		finish.
	^ self target
]

{ #category : 'private' }
BASvgExporter >> newCanvas: anExtent [

	| aSurface |
	aSurface := AeCairoSVGSurface
		            extent: anExtent
		            to: self target.

	^ AeCanvas newFor: aSurface
]
