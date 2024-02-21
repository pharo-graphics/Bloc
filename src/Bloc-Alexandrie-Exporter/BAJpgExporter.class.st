"
I export bloc elements as JPG file.

```
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipseGeometry new.
element size: 400@200.

(BAExporter jpg
	element: element;
	target: 'test.jpg' asFileReference;
	export) inspect
```

"
Class {
	#name : #BAJpgExporter,
	#superclass : #BAFileExporter,
	#instVars : [
		'isProgressive',
		'quality'
	],
	#category : #'Bloc-Alexandrie-Exporter'
}

{ #category : #accessing }
BAJpgExporter >> extension [

	^ 'jpg'
]

{ #category : #private }
BAJpgExporter >> finishExport: aCanvas [
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
BAJpgExporter >> initialize [

	super initialize.

	isProgressive := true.
	quality := 100. "best quality"
	background := Color white
]

{ #category : #accessing }
BAJpgExporter >> isProgressive [

	^ isProgressive
]

{ #category : #accessing }
BAJpgExporter >> isProgressive: aBoolean [

	isProgressive := aBoolean
]

{ #category : #private }
BAJpgExporter >> newCanvas: anExtent [

	^ AeCanvas extent: anExtent
]

{ #category : #accessing }
BAJpgExporter >> quality [

	^ quality
]

{ #category : #accessing }
BAJpgExporter >> quality: aNumber [
	"Quality must be between 0 and 100"
	
	quality := aNumber
]
