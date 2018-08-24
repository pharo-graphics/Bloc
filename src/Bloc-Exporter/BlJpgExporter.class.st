"
I export bloc elements as JPG file.

[[[
| element |
element := BlElement new.
element background: Color red.
element geometry: BlEllipse new.
element size: 400@200.

(BlExporter jpg element: element; fileName: 'test.jpg'; export) inspect
]]]
"
Class {
	#name : #BlJpgExporter,
	#superclass : #BlFileExporter,
	#instVars : [
		'isProgressive',
		'quality',
		'backgroundColor'
	],
	#category : 'Bloc-Exporter'
}

{ #category : #accessing }
BlJpgExporter >> backgroundColor [
	<return: #Color>

	^ backgroundColor
]

{ #category : #accessing }
BlJpgExporter >> backgroundColor: aColor [
	backgroundColor := aColor
]

{ #category : #'instance creation' }
BlJpgExporter >> createCanvas: anExtent [
	| aCanvas |

	aCanvas := Bloc preferableSpartaCanvas extent: anExtent.
	
	"make sure that canvas has a background color, because JPG does not support transparency"
	aCanvas fill
		paint: self backgroundColor;
		path: aCanvas bounds;
		draw.

	^ aCanvas
]

{ #category : #'api - exporting' }
BlJpgExporter >> export [
	<return: #FileReference>

	^ self doExport: [ :aCanvas |
		| aForm |
		
		aForm := aCanvas asForm.
	
		self fileName asFileReference ensureDelete.
		PluginBasedJPEGReadWriter
			putForm: aForm
			quality: self quality
			progressiveJPEG: self isProgressive
			onFileNamed: self fileName.
		
		self fileName asFileReference ]
]

{ #category : #'api - exporting' }
BlJpgExporter >> extension [
	^ 'jpg'
]

{ #category : #initialization }
BlJpgExporter >> initialize [
	super initialize.

	isProgressive := true.
	quality := 100. "best quality"
	backgroundColor := Color white
]

{ #category : #accessing }
BlJpgExporter >> isProgressive [
	<return: #Boolean>

	^ isProgressive
]

{ #category : #accessing }
BlJpgExporter >> isProgressive: aBoolean [
	isProgressive := aBoolean
]

{ #category : #accessing }
BlJpgExporter >> quality [
	^ quality
]

{ #category : #accessing }
BlJpgExporter >> quality: aNumber [
	
	self
		assert: [ aNumber between: 0 and: 100 ]
		description: [ 'Quality must be between 0 and 100' ].
	
	quality := aNumber
]
