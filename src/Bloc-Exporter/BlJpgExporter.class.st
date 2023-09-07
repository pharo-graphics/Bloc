"
I export bloc elements as JPG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BlExporter jpg
	element: element;
	target: 'test.jpg' asFileReference;
	export) inspect
```

"
Class {
	#name : #BlJpgExporter,
	#superclass : #BlFileExporter,
	#instVars : [
		'isProgressive',
		'quality'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #accessing }
BlJpgExporter >> extension [

	^ 'jpg'
]

{ #category : #private }
BlJpgExporter >> finishExport: aCanvas [
	"Answer a file reference to the exported JPG."

	self target ensureDelete.

	PluginBasedJPEGReadWriter
		putForm: aCanvas asForm
		quality: self quality
		progressiveJPEG: self isProgressive
		onFileNamed: self target.
	
	^ self target
]

{ #category : #initialization }
BlJpgExporter >> initialize [

	super initialize.

	isProgressive := true.
	quality := 100. "best quality"
	background := Color white
]

{ #category : #accessing }
BlJpgExporter >> isProgressive [

	^ isProgressive
]

{ #category : #accessing }
BlJpgExporter >> isProgressive: aBoolean [

	isProgressive := aBoolean
]

{ #category : #private }
BlJpgExporter >> newCanvas: anExtent [

	^ AeCanvas extent: anExtent
]

{ #category : #accessing }
BlJpgExporter >> quality [

	^ quality
]

{ #category : #accessing }
BlJpgExporter >> quality: aNumber [
	"Quality must be between 0 and 100"
	
	quality := aNumber
]
