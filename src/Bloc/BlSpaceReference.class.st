Class {
	#name : #BlSpaceReference,
	#superclass : #Object,
	#category : #'Bloc-Space'
}

{ #category : #testing }
BlSpaceReference >> isAttachedToSceneGraph [
	^ false
]

{ #category : #testing }
BlSpaceReference >> isDetachedFromSceneGraph [
	^ false
]

{ #category : #testing }
BlSpaceReference >> isNull [
	^ false
]

{ #category : #enumerating }
BlSpaceReference >> spaceDo: aBlock [
	"Evaluate a given block with a bloc space as an argument"
	
	
]
