Class {
	#name : #BlElementHoveredState,
	#superclass : #BlElementUniqueState,
	#category : #'Bloc-Basic-State'
}

{ #category : #enumerating }
BlElementHoveredState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementHoveredStateEventHandler uniqueInstance
]

{ #category : #printing }
BlElementHoveredState >> printOn: aStream [
	aStream nextPutAll: 'hovered'
]

{ #category : #accessing }
BlElementHoveredState >> priority [
	^ 10
]
