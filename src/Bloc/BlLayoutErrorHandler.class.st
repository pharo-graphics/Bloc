Class {
	#name : #BlLayoutErrorHandler,
	#superclass : #BlErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlLayoutErrorHandler >> matches: aFramePhase [
	^ aFramePhase isLayoutPhase
]
