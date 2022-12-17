Class {
	#name : #BlIdleErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlIdleErrorHandler >> matches: aFramePhase [
	^ aFramePhase isIdlePhase
]

{ #category : #'error handling' }
BlIdleErrorHandler >> processError: aHandledError [
	
]
