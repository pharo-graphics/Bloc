Class {
	#name : #BlAnimation,
	#superclass : #BlBaseAnimation,
	#instVars : [
		'duration',
		'easing'
	],
	#category : #'Bloc-Animation-Basic'
}

{ #category : #pulse }
BlAnimation >> applyValue: aValue [
	
]

{ #category : #'delta computing' }
BlAnimation >> computeDelta: aProgress [
	^ easing interpolate: aProgress
]

{ #category : #pulse }
BlAnimation >> doStep [
	self applyValue: (self valueForStep: (self computeDelta: progress))
]

{ #category : #accessing }
BlAnimation >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations"
	<return: #Duration>

	^ duration
]

{ #category : #'api - configuration' }
BlAnimation >> duration: aDuration [
	self
		assert: [ aDuration > 0 seconds ]
		description: [ 'Duration must be positive' ].

	duration := aDuration asDuration
]

{ #category : #accessing }
BlAnimation >> easing [
	^ easing
]

{ #category : #accessing }
BlAnimation >> easing: anObject [
	easing := anObject
]

{ #category : #initialization }
BlAnimation >> initialize [
	super initialize.
	
	duration := 1 second.	"configurable"
	easing := BlEasing linear
]

{ #category : #pulse }
BlAnimation >> valueForStep: aDelta [
	
]
