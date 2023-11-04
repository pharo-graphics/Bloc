Class {
	#name : 'BlElementPressedStateEventHandler',
	#superclass : 'BlElementStateEventHandler',
	#package : 'Bloc',
	#tag : 'Basic-State'
}

{ #category : 'mouse handlers' }
BlElementPressedStateEventHandler >> dragEndEvent: anEvent [
	self element: anEvent currentTarget pressed: false
]

{ #category : 'mouse handlers' }
BlElementPressedStateEventHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.
	self element: anEvent currentTarget pressed: true
]

{ #category : 'private' }
BlElementPressedStateEventHandler >> element: anElement pressed: aBoolean [
	aBoolean
		ifTrue: [ anElement states addState: BlElementState pressed ]
		ifFalse: [ anElement states removeState: BlElementState pressed ]
]

{ #category : 'api - accessing' }
BlElementPressedStateEventHandler >> eventsToHandle [
	^ {
		BlDragEndEvent.
		BlDragStartEvent.
		BlMouseDownEvent.
		BlMouseUpEvent
	}
]

{ #category : 'mouse handlers' }
BlElementPressedStateEventHandler >> mouseDownEvent: anEvent [
	anEvent consumed: true.
	self element: anEvent currentTarget pressed: true
]

{ #category : 'mouse handlers' }
BlElementPressedStateEventHandler >> mouseUpEvent: anEvent [
	anEvent consumed: true.
	self element: anEvent currentTarget pressed: false
]
