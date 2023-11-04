Class {
	#name : 'BlIdleErrorHandler',
	#superclass : 'BlSingleErrorHandler',
	#package : 'Bloc',
	#tag : 'Basic-Errors'
}

{ #category : 'testing' }
BlIdleErrorHandler >> matches: aFramePhase [
	^ aFramePhase isIdlePhase
]

{ #category : 'error handling' }
BlIdleErrorHandler >> processError: aHandledError [
	
]
