"
I am an exporter of Bloc elements to certain output format, that each of my subclasses define.
"
Class {
	#name : #BlExporter,
	#superclass : #Object,
	#instVars : [
		'element',
		'scale',
		'background'
	],
	#category : #'Bloc-Exporter'
}

{ #category : #'instance creation' }
BlExporter class >> form [
	^ BlFormExporter new
]

{ #category : #'instance creation' }
BlExporter class >> jpg [
	^ BlJpgExporter new
]

{ #category : #'instance creation' }
BlExporter class >> pdf [
	^ BlPdfExporter new
]

{ #category : #'instance creation' }
BlExporter class >> png [
	^ BlPngExporter new
]

{ #category : #'instance creation' }
BlExporter class >> svg [
	^ BlSvgExporter new
]

{ #category : #accessing }
BlExporter >> background [

	^ background
]

{ #category : #'api - configuration' }
BlExporter >> background: aColorOrPaint [

	background := aColorOrPaint
]

{ #category : #private }
BlExporter >> computeBounds [

	| anElement aBoundsInLocal aBoundsInParent |
	anElement := self element.
	
	aBoundsInLocal := (anElement effectBounds: BlBounds new)
		merge: anElement boundsInLocal;
		merge: anElement visualBounds.

	aBoundsInParent := anElement localBoundsToParent: aBoundsInLocal copy.
	
	^ aBoundsInParent
]

{ #category : #accessing }
BlExporter >> element [
	"Return an element to be exported"
	
	^ element
]

{ #category : #'api - configuration' }
BlExporter >> element: aBlElement [
	"Specify an element to be exorted"
	
	element := aBlElement
]

{ #category : #'api - exporting' }
BlExporter >> export [
	
	| aCanvas aBounds |
	element forceLayout.

	aBounds := self computeBounds.
	
	aCanvas := self newCanvas: (aBounds extent * scale).

	aCanvas
		clear: self background;
		pathScale: scale asPoint;
		pathTranslate: aBounds origin negated.
	element aeFullDrawOn: aCanvas.
	
	^ self finishExport: aCanvas
]

{ #category : #'api - exporting' }
BlExporter >> finishExport: aeCanvas [
	"Do finish the canvas and return the export result."

	self subclassResponsibility
]

{ #category : #initialization }
BlExporter >> initialize [
	super initialize.
	
	scale := 1.0.
	background := Color transparent
]

{ #category : #'instance creation' }
BlExporter >> newCanvas: anExtent [
	"Create a suitable canvas of a given size used for the export"
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlExporter >> scale [

	^ scale
]

{ #category : #'api - configuration' }
BlExporter >> scale: aNumber [
	"Scale horizontally and vertically by aNumber. Scale must be positive."

	scale := aNumber
]
