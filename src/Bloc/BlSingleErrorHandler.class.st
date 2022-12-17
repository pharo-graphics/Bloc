Class {
	#name : #BlSingleErrorHandler,
	#superclass : #BlErrorHandler,
	#instVars : [
		'error'
	],
	#category : #'Bloc-Basic-Errors'
}

{ #category : #comparing }
BlSingleErrorHandler >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
BlSingleErrorHandler >> error [
	<return: #BlHandledError>

	^ error
]

{ #category : #accessing }
BlSingleErrorHandler >> error: aHandledError [
	
	error := aHandledError
]

{ #category : #accessing }
BlSingleErrorHandler >> errors [
	^ { self error }
]

{ #category : #testing }
BlSingleErrorHandler >> hasError [
	<return: #Boolean>

	^ error isNotNil
]

{ #category : #comparing }
BlSingleErrorHandler >> hash [
	^ self class hash
]

{ #category : #'error handling' }
BlSingleErrorHandler >> registerError: aHandledError [
	"Register a given handled error for further debugging"

	self error: aHandledError
]
