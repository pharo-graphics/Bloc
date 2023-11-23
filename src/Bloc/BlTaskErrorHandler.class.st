Class {
	#name : #BlTaskErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlTaskErrorHandler >> matches: aFramePhase [
	^ aFramePhase isTaskPhase
]
