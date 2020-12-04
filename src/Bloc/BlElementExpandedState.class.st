Class {
	#name : #BlElementExpandedState,
	#superclass : #BlElementUniqueState,
	#category : #'Bloc-Basic-State'
}

{ #category : #enumerating }
BlElementExpandedState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementExpandedStateEventHandler uniqueInstance
]

{ #category : #printing }
BlElementExpandedState >> printOn: aStream [
	aStream nextPutAll: 'expanded'
]

{ #category : #accessing }
BlElementExpandedState >> priority [
	^ UserPriority
]
