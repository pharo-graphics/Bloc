"
I am responsible for error handling that occur in the `BlElement`


"
Class {
	#name : #BlErrorHandler,
	#superclass : #Object,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #private }
BlErrorHandler >> convertToHandledError: anError in: anElement [

	| aHandledError |
	aHandledError := BlHandledError new.
	aHandledError error: anError freeze.
	aHandledError errorHandler: self.
	aHandledError element: anElement.
	aHandledError framePhase: (self framePhaseOf: anElement).

	^ aHandledError
]

{ #category : #accessing }
BlErrorHandler >> errors [
	"Return a collection of `BlHandledError`. Subclasses should override this default behavior."

	^ #()
]

{ #category : #accessing }
BlErrorHandler >> errorsForPhase: aFramePhase [

	^ self errors select: [ :aHandledError | aHandledError framePhase = aFramePhase ]
]

{ #category : #private }
BlErrorHandler >> framePhaseOf: anElement [

	^ anElement isAttachedToSceneGraph
		ifTrue: [ anElement space frame currentPhase ]
		ifFalse: [ BlSpaceFrameUnknownPhase new ]
]

{ #category : #private }
BlErrorHandler >> handleCriticalError: aHandledError [
	"Handle an error that no one know how to handle.
	I stop the space and crash the system"
	
	aHandledError error freeze.
	[ aHandledError error debug ] fork
]

{ #category : #'error handling' }
BlErrorHandler >> handleError: anError in: anElement [
	"Handle a given error that comes from a provided visual element"

	| aHandledError |
	aHandledError := self convertToHandledError: anError in: anElement.

	self registerError: aHandledError.
	self processError: aHandledError
]

{ #category : #testing }
BlErrorHandler >> hasError [
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlErrorHandler >> matches: aFramePhase [

	^ self subclassResponsibility
]

{ #category : #'error handling' }
BlErrorHandler >> processError: aHandledError [

	self subclassResponsibility
]

{ #category : #'error handling' }
BlErrorHandler >> registerError: aHandledError [
	"Register a given handled error for further debugging"

	self subclassResponsibility
]

{ #category : #enumerating }
BlErrorHandler >> with: anElement do: aBlock [
	"Evaluate a given block while handling errors"

	self with: anElement do: aBlock failed: [ ]
]

{ #category : #enumerating }
BlErrorHandler >> with: anElement do: aBlock failed: aFailBlock [
	"Evaluate a given block while handling errors"

	self hasError
		ifFalse: [
			aBlock
				on: Error
				do: [ :anError |
					self handleError: anError in: anElement.
					aFailBlock cull: self errors ] ]
		ifTrue: [
			(self errorsForPhase: (self framePhaseOf: anElement))
				ifEmpty: [
					aBlock
						on: Error
						do: [ :anError |
							self handleError: anError in: anElement.
							aFailBlock cull: self errors ] ]
				ifNotEmpty: [ aFailBlock cull: self errors ] ]
]
