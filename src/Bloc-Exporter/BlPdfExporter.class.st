"
I export bloc elements as PDF file.

[[[
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter pdf element: element; fileName: 'test.pdf'; export) inspect
]]]
"
Class {
	#name : #BlPdfExporter,
	#superclass : #BlFileExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlPdfExporter >> createCanvas: anExtent [
	^ Bloc preferableSpartaCanvas pdf: self fileName extent: anExtent
]

{ #category : #'api - exporting' }
BlPdfExporter >> export [
	<return: #FileReference>

	^ self doExport: [ :aCanvas |
		aCanvas flush.
		self fileName asFileReference ]
]

{ #category : #'api - exporting' }
BlPdfExporter >> extension [
	^ 'pdf'
]
