Class {
	#name : #BlMorphicWorldState,
	#superclass : #WorldState,
	#instVars : [
		'element',
		'display'
	],
	#category : #'BlocHost-Morphic-World'
}

{ #category : #canvas }
BlMorphicWorldState >> assuredCanvas [

	(self canvas isNil or: [(self canvas extent ~= self viewBox extent) or: [self canvas form depth ~= Display depth]])
		ifTrue:
			["allocate a new offscreen canvas the size of the window"
			self canvas: (display defaultCanvasClass extent: self viewBox extent)].

	^ self canvas
]

{ #category : #accessing }
BlMorphicWorldState >> display [
	<return: #Form>

	^ display
]

{ #category : #accessing }
BlMorphicWorldState >> display: aForm [
	display := aForm
]

{ #category : #'update cycle' }
BlMorphicWorldState >> displayWorld: aWorld submorphs: submorphs [
	element invalidRect: (BlBounds fromRectangle: (0@0 extent: aWorld extent))
]

{ #category : #'update cycle' }
BlMorphicWorldState >> doOneCycleFor: aWorld [		
	self doOneCycleNowFor: aWorld
]

{ #category : #'update cycle' }
BlMorphicWorldState >> doOneCycleNowFor: aWorld [
	self element isAttachedToSceneGraph
		ifTrue: [
			self element space host universe pulseSynchronously.
			10 milliSeconds wait ]
]

{ #category : #accessing }
BlMorphicWorldState >> element [
	^ element
]

{ #category : #accessing }
BlMorphicWorldState >> element: anObject [
	element := anObject
]

{ #category : #initialization }
BlMorphicWorldState >> initialize [
	super initialize.
	
	self currentCursor: Cursor normal
]

{ #category : #canvas }
BlMorphicWorldState >> recordDamagedRect: damageRect [
	element invalidRect: (BlBounds fromRectangle: damageRect)
]
