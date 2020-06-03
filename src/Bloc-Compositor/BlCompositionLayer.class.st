Class {
	#name : #BlCompositionLayer,
	#superclass : #Object,
	#instVars : [
		'parent',
		'needsComposition'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionLayer >> asSkiaLayer [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BlCompositionLayer >> attachToParent: aCompositionLayer [
	parent := aCompositionLayer
]

{ #category : #accessing }
BlCompositionLayer >> children [
	^ #()
]

{ #category : #'private - composition' }
BlCompositionLayer >> cleanNeedsComposition [
	needsComposition := false
]

{ #category : #'private - composition' }
BlCompositionLayer >> computeNeedsComposition [
	
]

{ #category : #'as yet unclassified' }
BlCompositionLayer >> detachFromParent [
	parent := nil
]

{ #category : #drawing }
BlCompositionLayer >> drawOnSpartaCanvas: aCanvas [
]

{ #category : #testing }
BlCompositionLayer >> hasParent [
	^ parent isNotNil
]

{ #category : #initialization }
BlCompositionLayer >> initialize [
	super initialize.
	
	needsComposition := true
]

{ #category : #'private - composition' }
BlCompositionLayer >> markNeedsComposition [
	needsComposition := true.
]

{ #category : #accessing }
BlCompositionLayer >> name [
	^ self subclassResponsibility
]

{ #category : #'private - composition' }
BlCompositionLayer >> needsComposition [
	^ needsComposition
]

{ #category : #accessing }
BlCompositionLayer >> parent [
	<return: #BlCompositionLayer>

	^ parent
]

{ #category : #accessing }
BlCompositionLayer >> removeFromParent [
	self hasParent
		ifFalse: [ ^ self ].

	self parent removeLayer: self
]
