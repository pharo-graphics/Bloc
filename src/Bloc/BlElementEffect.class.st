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
	#category : #'Bloc-Effect'
}

{ #category : #geometry }
BlElementEffect >> computeBounds: aBlBounds [
	"Compute effect bounds based on provided geometry bounds.
	Default implementation simply returns given bounds"

	^ aBlBounds
]

{ #category : #geometry }
BlElementEffect >> computeEffectBoundsInto: aBlBounds [

	^ self computeBounds: aBlBounds
]

{ #category : #testing }
BlElementEffect >> isNullEffect [
	^ false
]

{ #category : #initialization }
BlElementEffect >> on: anElement [
]

{ #category : #testing }
BlElementEffect >> wantsCompositionLayer [
	^ false
]
