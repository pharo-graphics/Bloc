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

	^ progress
]

{ #category : #accessing }
BlAnimationStepEvent >> progress: aNumber [
	"Establish the progress, which must be within interval [0...1]"

	progress := aNumber
]
