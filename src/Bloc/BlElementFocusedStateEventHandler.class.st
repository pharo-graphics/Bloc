Class {
	#name : #BlElementFocusedStateEventHandler,
	#superclass : #BlElementStateEventHandler,
	#category : 'Bloc-Basic-State'
}

{ #category : #private }
BlElementFocusedStateEventHandler >> element: anElement focused: aBoolean [
	aBoolean
		ifTrue: [ anElement states addState: BlElementState focused ]
		ifFalse: [ anElement states removeState: BlElementState focused ]
]

{ #category : #'api - accessing' }
BlElementFocusedStateEventHandler >> eventsToHandle [
	^ {
		BlFocusInEvent.
		BlFocusOutEvent
	}
]

{ #category : #'focus handlers' }
BlElementFocusedStateEventHandler >> focusInEvent: anEvent [
	self element: anEvent currentTarget focused: true
]

{ #category : #'focus handlers' }
BlElementFocusedStateEventHandler >> focusOutEvent: anEvent [
	self element: anEvent currentTarget focused: false
]
