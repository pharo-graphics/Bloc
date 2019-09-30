"
I am the abstract root class for effects.
I define the default drawing strategy (before & after).
My subclasses can be composed as a chain of effects.
I can influence the bounds of my owner (used to clip my owner).
"
Class {
	#name : #BlElementEffect,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'input'
	],
	#category : #'Bloc-Effect'
}

{ #category : #'as yet unclassified' }
BlElementEffect class >> on: anObject [
	^ self new
		on: anObject;
		yourself
]

{ #category : #geometry }
BlElementEffect >> computeBounds: aBlBounds [
	"Compute effect bounds based on provided geometry bounds.
	Default implementation simply returns given bounds"
	<return: #BlBounds>

	^ aBlBounds
]

{ #category : #geometry }
BlElementEffect >> effectBounds [
	^ (self effectBounds: BlBounds new) asRectangle
]

{ #category : #geometry }
BlElementEffect >> effectBounds: aBlBounds [
	^ self computeBounds: (aBlBounds rectangle: self input visualBounds)
]

{ #category : #accessing }
BlElementEffect >> input [
	^ input
]

{ #category : #accessing }
BlElementEffect >> input: anElementOrEffect [
	input := anElementOrEffect
]

{ #category : #initialization }
BlElementEffect >> on: anElement [
	self input 
		ifNil: [ self input: anElement ] 
		ifNotNil: [ :anInput | anInput on: anElement ]
]

{ #category : #copying }
BlElementEffect >> postCopy [
	super postCopy.
	input := nil
]
