"
I am an exporter of Bloc elements to certain output format, that each of my subclasses define.
"
Class {
	#name : #BAExporter,
	#superclass : #Object,
	#instVars : [
		'element',
		'scale',
		'background'
	],
	#category : #'Bloc-Alexandrie-Exporter'
}

{ #category : #'instance creation' }
BAExporter class >> form [
	^ BAFormExporter new
]

{ #category : #'instance creation' }
BAExporter class >> jpg [
	^ BAJpgExporter new
]

{ #category : #'instance creation' }
BAExporter class >> pdf [
	^ BAPdfExporter new
]

{ #category : #'instance creation' }
BAExporter class >> png [
	^ BAPngExporter new
]

{ #category : #'instance creation' }
BAExporter class >> svg [
	^ BASvgExporter new
]

{ #category : #accessing }
BAExporter >> background [

	^ background
]

{ #category : #'api - configuration' }
BAExporter >> background: aColorOrPaint [

	background := aColorOrPaint
]

{ #category : #accessing }
BAExporter >> element [
	"Return an element to be exported"
	
	^ element
]

{ #category : #'api - configuration' }
BAExporter >> element: aBlElement [
	"Specify an element to be exorted"
	
	element := aBlElement
]

{ #category : #'api - exporting' }
BAExporter >> export [

	| aCanvas aBounds |
	element isLayoutRequested ifTrue: [ element forceLayout ].

	aBounds := element invalidationBoundsInParent.

	aCanvas := self newCanvas: aBounds extent * scale.

	aCanvas
		clear: self background;
		pathScale: scale asPoint;
		pathTranslate: aBounds origin negated.
	element aeFullDrawOn: aCanvas.

	^ self finishExport: aCanvas
]

{ #category : #'api - exporting' }
BAExporter >> finishExport: aeCanvas [
	"Do finish the canvas and return the export result."

	self subclassResponsibility
]

{ #category : #initialization }
BAExporter >> initialize [
	super initialize.
	
	scale := 1.0.
	background := Color transparent
]

{ #category : #'instance creation' }
BAExporter >> newCanvas: anExtent [
	"Create a suitable canvas of a given size used for the export"
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BAExporter >> scale [

	^ scale
]

{ #category : #'api - configuration' }
BAExporter >> scale: aNumber [
	"Scale horizontally and vertically by aNumber. Scale must be positive."

	scale := aNumber
]
