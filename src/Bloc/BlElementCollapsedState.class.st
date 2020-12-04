Class {
	#name : #BlElementCollapsedState,
	#superclass : #BlElementExpansionState,
	#category : #'Bloc-Basic-State'
}

{ #category : #enumerating }
BlElementCollapsedState >> optionalOnAddedTo: anElement [
	anElement dispatchEvent: BrCollapsedEvent new
]

{ #category : #printing }
BlElementCollapsedState >> printOn: aStream [
	aStream nextPutAll: 'collapsed'
]
