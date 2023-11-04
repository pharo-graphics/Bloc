Class {
	#name : 'BlElementHoveredState',
	#superclass : 'BlElementUniqueState',
	#category : 'Bloc-Basic-State'
}

{ #category : 'enumerating' }
BlElementHoveredState >> optionalEventHandlerDo: aBlock [
	aBlock value: BlElementHoveredStateEventHandler uniqueInstance
]

{ #category : 'enumerating' }
BlElementHoveredState >> optionalOnAddedTo: anElement [
	anElement dispatchEvent: (BlElementHoveredEvent new element: anElement)
]

{ #category : 'enumerating' }
BlElementHoveredState >> optionalOnRemovedFrom: anElement [
	anElement dispatchEvent: (BlElementUnhoveredEvent new element: anElement)
]

{ #category : 'printing' }
BlElementHoveredState >> printOn: aStream [
	aStream nextPutAll: 'hovered'
]

{ #category : 'accessing' }
BlElementHoveredState >> priority [
	^ 10
]
