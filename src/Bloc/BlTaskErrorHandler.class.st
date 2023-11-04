Class {
	#name : 'BlTaskErrorHandler',
	#superclass : 'BlSingleErrorHandler',
	#package : 'Bloc',
	#tag : 'Basic-Errors'
}

{ #category : 'testing' }
BlTaskErrorHandler >> matches: aFramePhase [
	^ aFramePhase isTaskPhase
]
