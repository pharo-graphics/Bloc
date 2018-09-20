"
I am responsible for error handling that occur in the ${class:BlElement}$


"
Class {
	#name : #BlErrorHandler,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
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
BlErrorHandler >> handleCriticalError: anError in: anElement [
	"Handle an error that no one know how to handle.
	I stop the space and crash the system"
	
	anError freeze.
	[ anError debug ] fork
]

{ #category : #private }
BlErrorHandler >> handleError: anError in: anElement [
	self error: anError.
	self processError: anError in: anElement
]

{ #category : #testing }
BlErrorHandler >> hasError [
	<return: #Boolean>

	^ error isNotNil
]

{ #category : #testing }
BlErrorHandler >> matches: aFramePhase [
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #private }
BlErrorHandler >> processError: anError in: anElement [
	self subclassResponsibility
]

{ #category : #enumerating }
BlErrorHandler >> with: anElement do: aBlock [
	"Evaluate a given block while handling errors"

	self with: anElement do: aBlock failed: [  ]
]

{ #category : #enumerating }
BlErrorHandler >> with: anElement do: aBlock failed: aFailBlock [
	"Evaluate a given block while handling errors"

	self hasError
		ifFalse: [ aBlock on: Error do: [ :anError |
				self handleError: anError in: anElement.
				aFailBlock cull: anError ] ]
		ifTrue: [ aFailBlock cull: self error ]
]
