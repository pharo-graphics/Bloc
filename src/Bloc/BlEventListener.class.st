"
I handle common `BlSpace` and `BlElement` events following the Null-Object design pattern.

My subclasses can override my methods to define specific behavior.
"
Class {
	#name : #BlEventListener,
	#superclass : #BlBasicEventHandler,
	#category : #'Bloc-Events-Handler'
}

{ #category : #'focus handlers' }
BlEventListener >> blurEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> clickAbortedEvent: anEvent [
	"a mouse down followed by a mouse up but in different a target"
]

{ #category : #'mouse handlers' }
BlEventListener >> clickEvent: anEvent [
	"The click event is fired when a pointing device button (usually a mouse's primary button) is pressed and released on a single element."
]

{ #category : #'mouse handlers' }
BlEventListener >> doubleClickEvent: anEvent [
]

{ #category : #'dnd handlers' }
BlEventListener >> dragEndEvent: anEvent [
]

{ #category : #'dnd handlers' }
BlEventListener >> dragEnterEvent: anEvent [
]

{ #category : #'dnd handlers' }
BlEventListener >> dragEvent: anEvent [
]

{ #category : #'dnd handlers' }
BlEventListener >> dragLeaveEvent: anEvent [
]

{ #category : #'dnd handlers' }
BlEventListener >> dragOverEvent: anEvent [
]

{ #category : #'dnd handlers' }
BlEventListener >> dragStartEvent: anEvent [
]

{ #category : #'dnd handlers' }
BlEventListener >> dropEvent: anEvent [
]

{ #category : #'api - accessing' }
BlEventListener >> eventsToHandle [
	^ BlUIEvent allSubclasses
]

{ #category : #'focus handlers' }
BlEventListener >> focusEvent: anEvent [
]

{ #category : #'focus handlers' }
BlEventListener >> focusInEvent: anEvent [
]

{ #category : #'focus handlers' }
BlEventListener >> focusOutEvent: anEvent [
]

{ #category : #'focus handlers' }
BlEventListener >> focusTransferEvent: anEvent [
]

{ #category : #'event handling' }
BlEventListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'keyboard handlers' }
BlEventListener >> keyDownEvent: anEvent [
]

{ #category : #'keyboard handlers' }
BlEventListener >> keyUpEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseEnterEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseEvent: anEvent [
	
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseLeaveEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseMoveEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseOutEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseOverEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseUpEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlEventListener >> mouseWheelEvent: anEvent [
]

{ #category : #'keyboard handlers' }
BlEventListener >> shortcutEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceCloseRequest: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceClosedEvent: anEvent [
	"Is sent after space is closed"
]

{ #category : #'space handlers' }
BlEventListener >> spaceEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceFocusInEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceFocusOutEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceIconChangedEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceMouseEnterEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceMouseLeaveEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceMovedEvent: anEvent [
]

{ #category : #'space handlers' }
BlEventListener >> spaceResizedEvent: anEvent [
	"Is sent after window extent was changed"
]

{ #category : #'keyboard handlers' }
BlEventListener >> textInputEvent: anEvent [
]

{ #category : #'api - event managing' }
BlEventListener >> wantsEvent: anEvent [

	anEvent isElementEvent
		ifTrue: [ ^ false ].

	^ anEvent isUIEvent or: [ anEvent isSpaceEvent ]
]
