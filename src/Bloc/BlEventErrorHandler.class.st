Class {
	#name : 'BlEventErrorHandler',
	#superclass : 'BlSingleErrorHandler',
	#package : 'Bloc',
	#tag : 'Basic-Errors'
}

{ #category : 'testing' }
BlEventErrorHandler >> matches: aFramePhase [
	^ aFramePhase isEventPhase
]
