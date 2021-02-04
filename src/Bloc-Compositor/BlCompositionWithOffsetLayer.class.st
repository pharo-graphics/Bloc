Class {
	#name : #BlCompositionWithOffsetLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'offset'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #initialization }
BlCompositionWithOffsetLayer >> initialize [
	super initialize.
	
	offset := 0@0
]

{ #category : #accessing }
BlCompositionWithOffsetLayer >> offset [
	<return: #Number>

	^ offset
]

{ #category : #accessing }
BlCompositionWithOffsetLayer >> offset: aPoint [
	offset = aPoint
		ifFalse: [ self markNeedsComposition ].
	offset := aPoint
]
