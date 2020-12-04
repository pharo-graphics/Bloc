Class {
	#name : #BlElementExpansionState,
	#superclass : #BlElementUniqueState,
	#category : #'Bloc-Basic-State'
}

{ #category : #enumerating }
BlElementExpansionState >> optionalEventHandlerDo: aBlock [
	aBlock value: (BlElementExpandedStateEventHandler uniqueInstance)
]

{ #category : #accessing }
BlElementExpansionState >> priority [
	^ UserPriority
]

{ #category : #accessing }
BlElementExpansionState >> type [
	^ BlElementExpansionState
]
