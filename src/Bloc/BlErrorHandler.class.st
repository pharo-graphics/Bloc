"
I am responsible for error handling that occur in the ${class:BlElement}$


"
Class {
	#name : #BlErrorHandler,
	#superclass : #Object,
	#instVars : [
		'error'
	],
	#category : #'Bloc-Basic-Errors'
}

{ #category : #accessing }
BlErrorHandler >> error [
	<return: #Error>

	^ error
]

{ #category : #accessing }
BlErrorHandler >> error: anError [
	
	self
		assert: [ anError isNotNil ]
		description: [ 'Error must not be nil' ].

	error := anError
]

{ #category : #private }
BlErrorHandler >> handleError: anError [
]

{ #category : #enumerating }
BlErrorHandler >> with: anElement do: aBlock [
	
]
