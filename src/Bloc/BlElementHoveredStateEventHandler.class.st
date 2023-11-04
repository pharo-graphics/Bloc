Class {
	#name : #BlElementHoveredStateEventHandler,
	#superclass : #BlElementStateEventHandler,
	#category : 'Bloc-Basic-State'
}

{ #category : 'mouse handlers' }
BlElementHoveredStateEventHandler >> dragEnterEvent: anEvent [
	self element: anEvent currentTarget hovered: true
]

{ #category : 'mouse handlers' }
BlElementHoveredStateEventHandler >> dragLeaveEvent: anEvent [
	self element: anEvent currentTarget hovered: false
]

{ #category : 'private' }
BlElementHoveredStateEventHandler >> element: anElement hovered: aBoolean [
	aBoolean
		ifTrue: [ anElement states addState: BlElementState hovered ]
		ifFalse: [ anElement states removeState: BlElementState hovered ]
]

{ #category : 'api - accessing' }
BlElementHoveredStateEventHandler >> eventsToHandle [
	^ {
		BlDragEnterEvent.
		BlDragLeaveEvent.
		BlMouseEnterEvent.
		BlMouseLeaveEvent
	}
]

{ #category : 'mouse handlers' }
BlElementHoveredStateEventHandler >> mouseEnterEvent: anEvent [
	self element: anEvent currentTarget hovered: true
]

{ #category : 'mouse handlers' }
BlElementHoveredStateEventHandler >> mouseLeaveEvent: anEvent [
	self element: anEvent currentTarget hovered: false
]
