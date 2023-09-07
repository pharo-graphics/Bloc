"
I export bloc elements as SVG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter svg
	element: element;
	target: 'test.svg' asFileReference;
	export) inspect
```
"
Class {
	#name : #BlSvgExporter,
	#superclass : #BlFileExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #accessing }
BlSvgExporter >> extension [

	^ 'svg'
]

{ #category : #private }
BlSvgExporter >> finishExport: aCanvas [
	"Answer a file reference to the exported SVG."

	aCanvas
		flush;
		finish.
	^ self target
]

{ #category : #private }
BlSvgExporter >> newCanvas: anExtent [

	| aSurface |
	aSurface := AeCairoSVGSurface
		            extent: anExtent
		            to: self target.

	^ AeCanvas newFor: aSurface
]
