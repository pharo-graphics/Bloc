"
I am an exporter of bloc elements to various output formats. See my subclasses for more info

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

{ #category : #'instance creation' }
BlExporter >> createCanvas: anExtent [
	"Create a suitable canvas of a given size used for the export"
	
	^ self subclassResponsibility
]

{ #category : #private }
BlExporter >> doExport: aFinalizingBlock [

	| aCanvas aBoundsInParent anElement |
	anElement := self element.
	anElement forceLayout.

	aBoundsInParent := self computeBounds.
	
	aCanvas := self createCanvas: (aBoundsInParent extent * self scale max: 1@1).

self flag: #todo. "Migrate to Alexandrie:"
"	aCanvas fill
		path: aCanvas bounds;
		paint: self background;
		draw.
"


	aCanvas
		pathScale: self scale asPoint;
		pathTranslate: (aBoundsInParent origin) negated.
	anElement aeFullDrawOn: aCanvas.
	
	^ aFinalizingBlock cull: aCanvas
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
	
	self subclassResponsibility
]

{ #category : #initialization }
BlExporter >> initialize [
	super initialize.
	
	scale := 1.
	background := Color transparent
]

{ #category : #accessing }
BlExporter >> scale [
	<return: #Number>

	^ scale
]

{ #category : #'api - configuration' }
BlExporter >> scaled: aNumber [
	"Scale by aNumber. Scale must be positive."

	scale := aNumber
]
