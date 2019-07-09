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

	(canvas isNil or: [(canvas extent ~= viewBox extent) or: [canvas form depth ~= Display depth]])
		ifTrue:
			["allocate a new offscreen canvas the size of the window"
			self canvas: (display defaultCanvasClass extent: viewBox extent)].

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
]

{ #category : #'update cycle' }
BlMorphicWorldState >> doOneCycleNowFor: aWorld [
]

{ #category : #accessing }
BlMorphicWorldState >> element [
	^ element
]

{ #category : #accessing }
BlMorphicWorldState >> element: anObject [
	element := anObject
]

{ #category : #canvas }
BlMorphicWorldState >> recordDamagedRect: damageRect [
	element invalidRect: (BlBounds fromRectangle: damageRect)
]
