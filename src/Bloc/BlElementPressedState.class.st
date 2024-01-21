Class {
	#name : #BlElementPressedState,
	#superclass : #BlElementUniqueState,
	#category : 'Bloc-Basic-State'
}

{ #category : #enumerating }
BlElementPressedState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementPressedStateEventHandler uniqueInstance
]

{ #category : #printing }
BlElementPressedState >> printOn: aStream [
	aStream nextPutAll: 'pressed'
]

{ #category : #accessing }
BlElementPressedState >> priority [
	^ 20
]
