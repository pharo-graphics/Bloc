Class {
	#name : 'BlAnimation',
	#superclass : 'BlBaseAnimation',
	#instVars : [
		'duration',
		'easing'
	],
	#category : 'Bloc-Animation-Basic',
	#package : 'Bloc-Animation',
	#tag : 'Basic'
}

{ #category : 'pulse' }
BlAnimation >> applyValue: anObject [
	"Change this animation to be at the point indicated by the argument. The argument is an object already interpolated."

	self subclassResponsibility
]

{ #category : 'pulse' }
BlAnimation >> doStep [

	self applyValue: (self valueForStep: (easing interpolate: progress))
]

{ #category : 'accessing' }
BlAnimation >> duration [

	^ duration
]

{ #category : 'api - configuration' }
BlAnimation >> duration: aDuration [
	"Establish the duration of this animation. Duration must be positive."

	duration := aDuration
]

{ #category : 'accessing' }
BlAnimation >> easing [
	"Answer the easing strategy that applies to the progress on each step."
	
	^ easing
]

{ #category : 'accessing' }
BlAnimation >> easing: aBlEasing [
	"Establish the easing strategy that applies to the progress."

	easing := aBlEasing
]

{ #category : 'initialization' }
BlAnimation >> initialize [

	super initialize.

	duration := 1 second.
	easing := BlEasing linear
]

{ #category : 'pulse' }
BlAnimation >> valueForStep: aNumber [
	"Answer an Object that corresponds to aNumber, which belongs to the [0,1] closed interval that ALREADY HAS the easing function applied."
	
	^ self subclassResponsibility
]
