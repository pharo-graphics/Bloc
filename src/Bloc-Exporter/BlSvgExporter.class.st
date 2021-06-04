"
I export bloc elements as SVG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter svg element: element; fileName: 'test.svg'; export) inspect
```

"
Class {
	#name : #BlSvgExporter,
	#superclass : #BlFileExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlSvgExporter >> createCanvas: anExtent [
	^ Bloc preferableSpartaCanvas svg: self fileName extent: anExtent
]

{ #category : #'api - exporting' }
BlSvgExporter >> export [
	<return: #FileReference>

	^ self doExport: [ :aCanvas |
		aCanvas flush.
		self fileName asFileReference ]
]

{ #category : #'api - exporting' }
BlSvgExporter >> extension [
	^ 'svg'
]
