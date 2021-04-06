Class {
	#name : #BlMorphicWorldEmbeddingElement,
	#superclass : #BlElement,
	#instVars : [
		'world',
		'worldState',
		'shouldBeMain'
	],
	#category : #'BlocHost-Morphic-World'
}

{ #category : #'instance creation' }
BlMorphicWorldEmbeddingElement class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Morph World'.
	aSpace extent: 1280@800.
	aSpace root: self new.
	aSpace show
]

{ #category : #'instance creation' }
BlMorphicWorldEmbeddingElement class >> openMain [
	<script: 'self open'>
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Morph World'.
	aSpace extent: 1280@800.
	aSpace root: self new beMain.
	aSpace show
]

{ #category : #accessing }
BlMorphicWorldEmbeddingElement >> activeHand [
	^ self world activeHand
		ifNil: [
			| aHand |
			
			aHand := world hands anyOne.
			world activeHand: aHand.
			aHand ]
]

{ #category : #actions }
BlMorphicWorldEmbeddingElement >> beMain [
	shouldBeMain := true.
	self isAttachedToSceneGraph
		ifTrue: [ world beMain ]
]

{ #category : #drawing }
BlMorphicWorldEmbeddingElement >> drawOnSpartaCanvas: aCanvas [
	super drawOnSpartaCanvas: aCanvas.

	world drawOnSpartaCanvas: aCanvas
]

{ #category : #initialization }
BlMorphicWorldEmbeddingElement >> initialize [
	super initialize.

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	shouldBeMain := false.
	worldState := BlMorphicWorldState new element: self.
	world := BlMorphicWorldMorph worldState: worldState.
	world worldState worldRenderer: (BlMorphicWorldRenderer new element: self; world: world).

	self addEventHandler: BlMorphicWorldEmbeddingEventHandler new.
	self when: BlMouseDownEvent do: [ self requestFocus ].

	self enqueueTask: (BlRepeatedTaskAction new delay: 20 milliSeconds; action: [ world runStepMethods ])
]

{ #category : #'hooks - children' }
BlMorphicWorldEmbeddingElement >> onAddedToSceneGraph [ 
	super onAddedToSceneGraph.
	
	shouldBeMain ifTrue: [ world beMain ]
]

{ #category : #layout }
BlMorphicWorldEmbeddingElement >> onLayout: aRectangle context: aBlElementBoundsUpdater [
	super onLayout: aRectangle context: aBlElementBoundsUpdater.

	world fullBounds.
	
	world viewBox = (0@0 extent: aRectangle extent)
		ifFalse: [ world viewBox: (0@0 extent: aRectangle extent) ].

	world displayExtent = aRectangle extent
		ifFalse: [ world displayExtent: aRectangle extent ]
]

{ #category : #layout }
BlMorphicWorldEmbeddingElement >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	world extent = self measuredExtent
		ifTrue: [ ^ self ].
	world extent: self measuredExtent
]

{ #category : #accessing }
BlMorphicWorldEmbeddingElement >> world [
	<return: #WorldMorph>

	^ world
]

{ #category : #accessing }
BlMorphicWorldEmbeddingElement >> world: aWorldMorph [
	world := aWorldMorph
]
