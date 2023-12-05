Class {
	#name : 'BlEventErrorHandler',
	#superclass : 'BlSingleErrorHandler',
	#category : 'Bloc-Basic-Errors',
	#package : 'Bloc',
	#tag : 'Basic-Errors'
}

{ #category : 'testing' }
BlEventErrorHandler >> matches: aFramePhase [
	^ aFramePhase isEventPhase
]
