"
I am an error handler that can point to a sole error.
"
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

	^ { error }
]

{ #category : #testing }
BlSingleErrorHandler >> hasError [

	^ error isNotNil
]

{ #category : #comparing }
BlSingleErrorHandler >> hash [

	^ self class hash
]

{ #category : #'error handling' }
BlSingleErrorHandler >> registerError: anError [
	"Register a given handled error for further debugging"

	error := anError
]
