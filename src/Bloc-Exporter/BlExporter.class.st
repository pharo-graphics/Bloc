"
I am an exporter of bloc elements to various output formats. See my subclasses for more info
"
Class {
	#name : #BlExporter,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element'
	],
	#category : 'Bloc-Exporter'
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

{ #category : #private }
BlExporter >> computeBounds [
	<return: #BlBounds>
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
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #private }
BlExporter >> doExport: aFinalizingBlock [
	| aCanvas aBoundsInParent anElement |

	anElement := self element.
	anElement forceLayout.

	aBoundsInParent := self computeBounds.
	
	aCanvas := self createCanvas: (aBoundsInParent extent max: 1@1).
	
	self
		drawOn: aCanvas
		during: [
			aCanvas transform
				by: [ :aTransform | aTransform translateBy: (aBoundsInParent origin) negated ]
				during: [ anElement fullDrawOnSpartaCanvas: aCanvas ] ].

	^ aFinalizingBlock cull: aCanvas
]

{ #category : #protected }
BlExporter >> drawOn: aCanvas during: aBlock [
	"By default we don't do any specific canvas preparations"

	aBlock cull: aCanvas
]

{ #category : #accessing }
BlExporter >> element [
	"Return an element to be exported"
	<return: #BlElement>
	
	^ element
]

{ #category : #'api - configuration' }
BlExporter >> element: aBlElement [
	"Specify an element to be exorted"
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must not be nil' ].
	
	element := aBlElement
]

{ #category : #'api - exporting' }
BlExporter >> export [
	"Start exporting process. Subclasses must implement me"
	
	self subclassResponsibility
]
