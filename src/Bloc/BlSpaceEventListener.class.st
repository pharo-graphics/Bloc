"
I handle Bloc space events (`BlSpaceEvent`).
"
Class {
	#name : #BlSpaceEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #'instance creation' }
BlSpaceEventListener class >> space: aStage [
	^ self new
		space: aStage;
		yourself
]

{ #category : #accessing }
BlSpaceEventListener >> focusProcessor [
	^ self space focusProcessor
]

{ #category : #'keyboard handlers' }
BlSpaceEventListener >> keyDownEvent: anEvent [
	self keyboardProcessor processKeyDown: anEvent
]

{ #category : #'keyboard handlers' }
BlSpaceEventListener >> keyUpEvent: anEvent [
	self keyboardProcessor processKeyUp: anEvent
]

{ #category : #accessing }
BlSpaceEventListener >> keyboardProcessor [
	^ self space keyboardProcessor
]

{ #category : #'mouse handlers' }
BlSpaceEventListener >> mouseDownEvent: anEvent [

	self mouseProcessor handleMouseDown: anEvent.
	self focusProcessor handleMouseDown: anEvent
]

{ #category : #'other handlers' }
BlSpaceEventListener >> mouseEvent: anEvent [
	
]

{ #category : #'mouse handlers' }
BlSpaceEventListener >> mouseMoveEvent: anEvent [
	self mouseProcessor handleMouseMove: anEvent
]

{ #category : #accessing }
BlSpaceEventListener >> mouseProcessor [

	^ self space mouseProcessor
]

{ #category : #'mouse handlers' }
BlSpaceEventListener >> mouseUpEvent: anEvent [

	self mouseProcessor handleMouseUp: anEvent
]

{ #category : #'mouse handlers' }
BlSpaceEventListener >> mouseWheelEvent: anEvent [

	self mouseProcessor processMouseScroll: anEvent
]

{ #category : #accessing }
BlSpaceEventListener >> space [
	^ space
]

{ #category : #accessing }
BlSpaceEventListener >> space: aBlSpace [
	space := aBlSpace
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceCloseRequest: anEvent [
	self space close
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceClosedEvent: anEvent [
	self mouseProcessor onSpaceClosed
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceEventsProcessedEvent: anEvent [
	self space keyboardProcessor handleSpaceEventProcessedEvent: anEvent
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceFocusInEvent: anEvent [

	self focusProcessor processWindowFocusIn: anEvent
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceFocusOutEvent: anEvent [
	self focusProcessor processWindowFocusOut: anEvent.
	self keyboardProcessor processWindowFocusOut: anEvent
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceMouseEnterEvent: anEvent [
	self mouseProcessor handleMouseEntered: anEvent
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceMouseLeaveEvent: anEvent [

	self mouseProcessor handleMouseLeft: anEvent
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceMovedEvent: anEvent [

  self space setPosition: anEvent position
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceResizedEvent: anEvent [
	"Is sent after window size was changed"

	self space setExtent: anEvent extent
]

{ #category : #'keyboard handlers' }
BlSpaceEventListener >> textInputEvent: anEvent [

	self keyboardProcessor processTextInput: anEvent
]
