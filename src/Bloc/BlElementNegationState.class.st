Class {
	#name : #BlElementNegationState,
	#superclass : #BlElementState,
	#instVars : [
		'state'
	],
	#category : #'Bloc-Basic-State'
}

{ #category : #comparing }
BlElementNegationState >> = anotherState [
	anotherState == self
		ifTrue: [ ^ true ].
		
	anotherState species == self species
		ifFalse: [ ^ false ].
		
	^ self state = anotherState state
]

{ #category : #comparing }
BlElementNegationState >> hash [
	^ self class hash bitXor: self state hash
]

{ #category : #testing }
BlElementNegationState >> matches: aSetOfStates [
	^ (self state matches: aSetOfStates) not
]

{ #category : #controlling }
BlElementNegationState >> not [
	^ self state
]

{ #category : #enumerating }
BlElementNegationState >> optionalEventHandlerDo: aBlock [
	state optionalEventHandlerDo: aBlock
]

{ #category : #printing }
BlElementNegationState >> printOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: 'not ';
		print: self state;
		nextPut: $)
]

{ #category : #accessing }
BlElementNegationState >> priority [
	^ self state priority
]

{ #category : #accessing }
BlElementNegationState >> state [
	^ state
]

{ #category : #accessing }
BlElementNegationState >> state: anObject [
	state := anObject
]
