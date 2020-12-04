Class {
	#name : #BlElementExpandedState,
	#superclass : #BlElementExpansionState,
	#category : #'Bloc-Basic-State'
}

{ #category : #enumerating }
BlElementExpandedState >> optionalOnAddedTo: anElement [
	anElement dispatchEvent: BrExpandedEvent new
]

{ #category : #printing }
BlElementExpandedState >> printOn: aStream [
	aStream nextPutAll: 'expanded'
]
