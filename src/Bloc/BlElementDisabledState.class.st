Class {
	#name : 'BlElementDisabledState',
	#superclass : 'BlElementUniqueState',
	#package : 'Bloc',
	#tag : 'Basic-State'
}

{ #category : 'enumerating' }
BlElementDisabledState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementDisabledStateEventHandler uniqueInstance
]

{ #category : 'printing' }
BlElementDisabledState >> printOn: aStream [
	aStream nextPutAll: 'disabled'
]

{ #category : 'accessing' }
BlElementDisabledState >> priority [
	^ 100
]
