Class {
	#name : #BlIdleErrorHandler,
	#superclass : #BlErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlIdleErrorHandler >> matches: aFramePhase [
	^ aFramePhase isIdlePhase
]
