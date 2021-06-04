"
I export bloc elements as PNG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter png element: element; fileName: 'test.png'; export) inspect
```

"
Class {
	#name : #BlPngExporter,
	#superclass : #BlFileExporter,
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlPngExporter >> createCanvas: anExtent [
	^ Bloc preferableSpartaCanvas extent: anExtent
]

{ #category : #'api - exporting' }
BlPngExporter >> export [
	<return: #FileReference>

	^ self doExport: [ :aCanvas |
		| aForm |
		aForm := aCanvas asForm.
		
		self fileName asFileReference ensureDelete.
		PNGReadWriter putForm: aForm onFileNamed: self fileName.
		
		self fileName asFileReference ]
]

{ #category : #'api - exporting' }
BlPngExporter >> extension [
	^ 'png'
]
