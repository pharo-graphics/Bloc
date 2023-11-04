Class {
	#name : 'BlCompositeErrorHandler',
	#superclass : 'BlErrorHandler',
	#instVars : [
		'errors',
		'errorHandlers'
	],
	#category : 'Bloc-Basic-Errors',
	#package : 'Bloc',
	#tag : 'Basic-Errors'
}

{ #category : 'instance creation' }
BlCompositeErrorHandler class >> withAll: aCollectionOfErrorHandlers [
	^ self new addErrorHandlers: aCollectionOfErrorHandlers
]

{ #category : 'adding' }
BlCompositeErrorHandler >> addErrorHandler: anErrorHandler [
	self errorHandlers add: anErrorHandler
]

{ #category : 'adding' }
BlCompositeErrorHandler >> addErrorHandlers: aCollectionOfErrorHandlers [
	self errorHandlers addAll: aCollectionOfErrorHandlers
]

{ #category : 'accessing' }
BlCompositeErrorHandler >> errorHandlers [
	<return: #Collection of: #BlErrorHandler>

	^ errorHandlers
]

{ #category : 'accessing' }
BlCompositeErrorHandler >> errors [
	^ errors
]

{ #category : 'testing' }
BlCompositeErrorHandler >> hasError [
	<return: #Boolean>

	^ self errors isNotEmpty
]

{ #category : 'initialization' }
BlCompositeErrorHandler >> initialize [
	super initialize.

	errorHandlers := Set new.
	errors := OrderedCollection new
]

{ #category : 'testing' }
BlCompositeErrorHandler >> matches: aFramePhase [
	^ self errorHandlers anySatisfy: [ :anErrorHandler | anErrorHandler matches: aFramePhase ]
]

{ #category : 'error handling' }
BlCompositeErrorHandler >> processError: aHandledError [
	self errorHandlers
		detect: [ :anErrorHandler | anErrorHandler matches: aHandledError framePhase ]
		ifFound: [ :anErrorHandler | anErrorHandler handleError: aHandledError error in: aHandledError element ]
		ifNone: [ self handleCriticalError: aHandledError ]
]

{ #category : 'error handling' }
BlCompositeErrorHandler >> registerError: aHandledError [
	self errors add: aHandledError
]
