Class {
	#name : #BlCompositionLayer,
	#superclass : #Object,
	#instVars : [
		'parent',
		'needsComposition',
		'session'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #printing }
BlCompositionLayer class >> printSymbolTree: anArray on: aStream [
]

{ #category : #converting }
BlCompositionLayer >> asSkiaLayer [
	^ self subclassResponsibility
]

{ #category : #converting }
BlCompositionLayer >> asSymbolTree [
	^ self subclassResponsibility
]

{ #category : #accessing }
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
BlCompositionLayer >> cleanNeedsCompositionFromAllLayers [
	self cleanNeedsComposition
]

{ #category : #'private - composition' }
BlCompositionLayer >> computeNeedsComposition [
	
]

{ #category : #accessing }
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
	
	needsComposition := true.
	session := Smalltalk session
]

{ #category : #testing }
BlCompositionLayer >> isValid [
	<return: #Boolean>
	
	^ session == Smalltalk session
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
