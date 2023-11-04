Class {
	#name : 'BlElementPressedState',
	#superclass : 'BlElementUniqueState',
	#package : 'Bloc',
	#tag : 'Basic-State'
}

{ #category : 'enumerating' }
BlElementPressedState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementPressedStateEventHandler uniqueInstance
]

{ #category : 'printing' }
BlElementPressedState >> printOn: aStream [
	aStream nextPutAll: 'pressed'
]

{ #category : 'accessing' }
BlElementPressedState >> priority [
	^ 20
]
