"
I am an error handler that delegates the responsibility to my children error handlers. I follow the Composite design pattern.
"
Class {
	#name : #BlCompositeErrorHandler,
	#superclass : #BlErrorHandler,
	#instVars : [
		'errors',
		'errorHandlers'
	],
	#category : #'Bloc-Basic-Errors'
}

{ #category : #'instance creation' }
BlCompositeErrorHandler class >> new [

	^ self withAll: #()
]

{ #category : #'instance creation' }
BlCompositeErrorHandler class >> withAll: aCollectionOfErrorHandlers [

	^ self basicNew
		initializeWithErrorHandlers: aCollectionOfErrorHandlers;
		yourself
]

{ #category : #adding }
BlCompositeErrorHandler >> addErrorHandler: anErrorHandler [

	errorHandlers := errorHandlers copyWith: anErrorHandler
]

{ #category : #adding }
BlCompositeErrorHandler >> addErrorHandlers: aCollectionOfErrorHandlers [

	errorHandlers := errorHandlers copyWithAll: aCollectionOfErrorHandlers
]

{ #category : #accessing }
BlCompositeErrorHandler >> errorHandlers [

	^ errorHandlers
]

{ #category : #accessing }
BlCompositeErrorHandler >> errors [

	^ errors
]

{ #category : #testing }
BlCompositeErrorHandler >> hasError [

	^ errors isNotEmpty
]

{ #category : #initialization }
BlCompositeErrorHandler >> initializeWithErrorHandlers: aCollection [

	self initialize.

	errors := #().
	errorHandlers := aCollection
]

{ #category : #testing }
BlCompositeErrorHandler >> matches: aFramePhase [

	errorHandlers ifNil: [ ^ false ].

	^ errorHandlers anySatisfy: [ :each | each matches: aFramePhase ]
]

{ #category : #'error handling' }
BlCompositeErrorHandler >> processError: anError [

	errorHandlers ifNil: [ ^ self handleCriticalError: anError ].

	errorHandlers
		detect: [ :each | each matches: anError framePhase ]
		ifFound: [ :each | each handleError: anError error in: anError element ]
		ifNone: [ self handleCriticalError: anError ]
]

{ #category : #'error handling' }
BlCompositeErrorHandler >> registerError: anError [

	errors := errors copyWith: anError
]
