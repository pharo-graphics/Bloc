"
I am a mock error handler used in unit tests to safely capture handled errors without opening debuggers.
"
Class {
	#name : #BlMockErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#instVars : [
		'handledErrors'
	],
	#category : #'Bloc-Tests-Basic-Errors'
}

{ #category : #accessing }
BlMockErrorHandler >> handledErrors [

	^ handledErrors
]

{ #category : #initialization }
BlMockErrorHandler >> initialize [

	super initialize.
	handledErrors := OrderedCollection new
]

{ #category : #testing }
BlMockErrorHandler >> matches: aFramePhase [

	^ true
]

{ #category : #'error handling' }
BlMockErrorHandler >> processError: aHandledError [

	handledErrors add: aHandledError
]
