Class {
	#name : #BlLayoutErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlLayoutErrorHandler >> matches: aFramePhase [
	^ aFramePhase isLayoutPhase
]

{ #category : #'error handling' }
BlLayoutErrorHandler >> processError: anError [
	anError inspect
]
