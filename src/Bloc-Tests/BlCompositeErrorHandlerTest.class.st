"
A BlCompositeErrorHandlerTest is a test class for testing the behavior of BlCompositeErrorHandler
"
Class {
	#name : #BlCompositeErrorHandlerTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Errors'
}

{ #category : #tests }
BlCompositeErrorHandlerTest >> testAddErrorHandler [

	| handler h1 h2 |
	handler := BlCompositeErrorHandler new.
	
	handler addErrorHandler: (h1 := BlDrawingErrorHandler new).
	handler addErrorHandler: (h2 := BlLayoutErrorHandler new).
	
	self assert: handler errorHandlers equals: { h1. h2 }
]

{ #category : #tests }
BlCompositeErrorHandlerTest >> testAddErrorHandlers [

	| handler h1 h2 |
	handler := BlCompositeErrorHandler new.
	
	h1 := BlDrawingErrorHandler new.
	h2 := BlLayoutErrorHandler new.
	
	handler addErrorHandlers: { h1. h2 }.
	
	self assert: handler errorHandlers equals: { h1. h2 }
]

{ #category : #tests }
BlCompositeErrorHandlerTest >> testErrors [

	| handler errors |
	handler := BlCompositeErrorHandler withAll: { BlDrawingErrorHandler new }.
	
	self deny: handler hasError.
	self assert: handler errors isEmpty.
	
	handler
		with: BlElement new
		do: [ 1/0 ]
		failed: [ :aCollection | errors := aCollection ].

	self assert: handler hasError.
	self assert: handler errors size equals: 1.
	self assert: handler errors equals: errors.

	handler
		with: BlElement new
		do: [ 1/0 ]
		failed: [ :aCollection | errors := aCollection ].

	self assert: handler hasError.
	self assert: handler errors size equals: 2.
	self assert: handler errors equals: errors.
]

{ #category : #tests }
BlCompositeErrorHandlerTest >> testWithAll [

	| handler h1 h2 |
	h1 := BlDrawingErrorHandler new.
	h2 := BlLayoutErrorHandler new.

	handler := BlCompositeErrorHandler withAll: { h1. h2 }.
		
	self assert: handler errorHandlers equals: { h1. h2 }
]
