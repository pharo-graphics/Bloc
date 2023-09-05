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

{ #category : #'instance creation' }
BlSvgExporter >> createCanvas: anExtent [

	| aSurface |
	aSurface := AeCairoSVGSurface
		            extent: anExtent
		            to: self target.

	^ AeCanvas newFor: aSurface
]

{ #category : #'api - exporting' }
BlSvgExporter >> export [
	"Answer a file reference to the exported SVG."

	^ self doExport: [ :aCanvas |
		aCanvas flush; finish.
		self target ]
]

{ #category : #'api - exporting' }
BlSvgExporter >> extension [
	^ 'svg'
]
