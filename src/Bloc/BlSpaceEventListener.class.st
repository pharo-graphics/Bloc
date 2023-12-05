Class {
	#name : 'BlSpaceEventListener',
	#superclass : 'BlEventListener',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'space',
		'mouseDragListener',
		'dragCollectionElement'
	],
	#category : 'Bloc-Space - Events',
	#package : 'Bloc',
	#tag : 'Space - Events'
}

{ #category : 'as yet unclassified' }
BlSpaceEventListener class >> space: aStage [
	^ self new
		space: aStage;
		yourself
]

{ #category : 'accessing' }
BlSpaceEventListener >> focusProcessor [
	^ self space focusProcessor
]

{ #category : 'other handlers' }
BlSpaceEventListener >> inputMethodEvent: anEvent [
]

{ #category : 'keyboard handlers' }
BlSpaceEventListener >> keyDownEvent: anEvent [
	self keyboardProcessor processKeyDown: anEvent
]

{ #category : 'keyboard handlers' }
BlSpaceEventListener >> keyUpEvent: anEvent [
	self keyboardProcessor processKeyUp: anEvent
]

{ #category : 'accessing' }
BlSpaceEventListener >> keyboardProcessor [
	^ self space keyboardProcessor
]

{ #category : 'mouse handlers' }
BlSpaceEventListener >> mouseDownEvent: anEvent [

	self testMouseProcessor handleMouseDown: anEvent.
	self focusProcessor handleMouseDown: anEvent
]

{ #category : 'other handlers' }
BlSpaceEventListener >> mouseEvent: anEvent [
	
]

{ #category : 'mouse handlers' }
BlSpaceEventListener >> mouseMoveEvent: anEvent [
	self testMouseProcessor handleMouseMove: anEvent
]

{ #category : 'mouse handlers' }
BlSpaceEventListener >> mouseUpEvent: anEvent [

	self testMouseProcessor handleMouseUp: anEvent
]

{ #category : 'mouse handlers' }
BlSpaceEventListener >> mouseWheelEvent: anEvent [

	self testMouseProcessor processMouseScroll: anEvent
]

{ #category : 'accessing' }
BlSpaceEventListener >> space [
	^ space
]

{ #category : 'accessing' }
BlSpaceEventListener >> space: aBlSpace [
	space := aBlSpace
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceCloseRequest: anEvent [
	self space close
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceClosedEvent: anEvent [
	self testMouseProcessor onSpaceClosed
]

{ #category : 'drag and drop' }
BlSpaceEventListener >> spaceDragCancelEvent: anEvent [
	anEvent delegate cancel: anEvent position.
	self space removeEventHandler: mouseDragListener
]

{ #category : 'drag and drop' }
BlSpaceEventListener >> spaceDragLiftEvent: anEvent [
	| aDelegate aPosition |

	aDelegate := anEvent delegate.
	aPosition := anEvent position.

	aDelegate lift: aPosition in: self space root.

	mouseDragListener := BlEventHandler
		on: BlMouseMoveEvent
		do: [ :aMouseMoveEvent | aDelegate drag: aMouseMoveEvent position ].

	self space addEventHandler: mouseDragListener
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceEventsProcessedEvent: anEvent [
	self space keyboardProcessor handleSpaceEventProcessedEvent: anEvent
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceFocusInEvent: anEvent [
	self focusProcessor processWindowFocusIn: anEvent
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceFocusOutEvent: anEvent [
	self focusProcessor processWindowFocusOut: anEvent.
	self keyboardProcessor processWindowFocusOut: anEvent
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceMouseEnterEvent: anEvent [
	self testMouseProcessor handleMouseEntered: anEvent
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceMouseLeaveEvent: anEvent [

	self testMouseProcessor handleMouseLeft: anEvent
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceMovedEvent: anEvent [
	self space setPosition: anEvent position
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceRedrawRequestedEvent: anEvent [
	self space
		invalidateAll;
		requestNextPulse
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceResizedEvent: anEvent [
	"Is sent after window size was changed"

	self space setExtent: anEvent extent
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceScaleFactorChangedEvent: anEvent [
	self space
		invalidateAll;
		requestNextPulse
]

{ #category : 'window handlers' }
BlSpaceEventListener >> spaceWakeUpEvent: anEvent [
	self space requestNextPulse
]

{ #category : 'accessing' }
BlSpaceEventListener >> testMouseProcessor [

	^ self space testMouseProcessor
]

{ #category : 'keyboard handlers' }
BlSpaceEventListener >> textInputEvent: anEvent [
	self keyboardProcessor processTextInput: anEvent
]
