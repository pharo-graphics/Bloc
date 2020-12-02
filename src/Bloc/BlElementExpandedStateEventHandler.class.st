Class {
	#name : #BlElementExpandedStateEventHandler,
	#superclass : #BlElementStateEventHandler,
	#category : #'Bloc-Basic-State'
}

{ #category : #private }
BlElementExpandedStateEventHandler >> element: anElement expanded: aBoolean [
	aBoolean
		ifTrue: [ anElement states removeState: BlElementState expanded ]
		ifFalse: [ anElement states addState: BlElementState expanded ]
]

{ #category : #'api - accessing' }
BlElementExpandedStateEventHandler >> eventsToHandle [
	^ { BlElementExpandedStateWish }
]

{ #category : #'api - event managing' }
BlElementExpandedStateEventHandler >> handleEvent: aBlElementExpandedStateWish [
	self
		element: aBlElementExpandedStateWish currentTarget
		expanded: aBlElementExpandedStateWish expanded
]
