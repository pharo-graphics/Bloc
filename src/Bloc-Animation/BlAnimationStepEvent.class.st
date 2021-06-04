"
I am sent after every animation step with current progress as a parameter

"
Class {
	#name : #BlAnimationStepEvent,
	#superclass : #BlEvent,
	#instVars : [
		'progress'
	],
	#category : #'Bloc-Animation-Events'
}

{ #category : #accessing }
BlAnimationStepEvent >> progress [
	<return: #Number>

	^ progress
]

{ #category : #accessing }
BlAnimationStepEvent >> progress: aNumber [
	self
		assert: [ aNumber between: 0 and: 1 ]
		description: [ 'Progress must be within interval [0...1]' ].

	progress := aNumber
]
