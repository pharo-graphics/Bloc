Class {
	#name : #BlEventErrorHandler,
	#superclass : #BlErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlEventErrorHandler >> matches: aFramePhase [
	^ aFramePhase isEventPhase
]
