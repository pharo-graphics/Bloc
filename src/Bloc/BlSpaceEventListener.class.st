Class {
	#name : #BlSpaceEventListener,
	#superclass : #BlEventListener,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'space',
		'mouseDragListener',
		'dragCollectionElement'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #'as yet unclassified' }
BlSpaceEventListener class >> space: aStage [
	^ self new
		space: aStage;
		yourself
]

{ #category : #accessing }
BlSpaceEventListener >> focusProcessor [
	^ self space focusProcessor
]

{ #category : #accessing }
BlSpaceEventListener >> gestureProcessor [
	^ self space gestureProcessor
]

{ #category : #'gesture handlers' }
BlSpaceEventListener >> gestureScrollEvent: anEvent [
	self gestureProcessor handleGesture: anEvent
]

{ #category : #'event handling' }
BlSpaceEventListener >> handleEvent: anEvent [
	super handleEvent: anEvent
]

{ #category : #'other handlers' }
BlSpaceEventListener >> inputMethodEvent: anEvent [
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

{ #category : #'other handlers' }
BlSpaceEventListener >> rotateEvent: anEvent [
]

{ #category : #'mouse handlers' }
BlSpaceEventListener >> scrollEvent: anEvent [
	self mouseProcessor processMouseScroll: anEvent
]

{ #category : #accessing }
BlSpaceEventListener >> space [
	^ space
]

{ #category : #accessing }
BlSpaceEventListener >> space: anObject [
	space := anObject
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceCloseRequest: anEvent [
	self space close
]

{ #category : #'drag and drop' }
BlSpaceEventListener >> spaceDragCancel: anEvent [
	anEvent delegate cancel: anEvent position.
	self space removeEventHandler: mouseDragListener
]

{ #category : #'drag and drop' }
BlSpaceEventListener >> spaceDragLift: anEvent [
	| aDelegate aPosition |

	aDelegate := anEvent delegate.
	aPosition := anEvent position.

	aDelegate lift: aPosition in: self space root.

	mouseDragListener := BlEventHandler
		on: BlMouseMoveEvent
		do: [ :aMouseMoveEvent | aDelegate drag: aMouseMoveEvent position ].

	self space addEventHandler: mouseDragListener
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceEventProcessedEvent: anEvent [
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
BlSpaceEventListener >> spaceMovedEvent: anEvent [
	self space setPosition: anEvent position
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceResizedEvent: anEvent [
	"Is sent after window size was changed"

	self space setExtent: anEvent extent
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceScaled: anEvent [
	self space
		beDirtyArea;
		requestNextPulse
]

{ #category : #'window handlers' }
BlSpaceEventListener >> spaceWakeUpEvent: anEvent [
	self space requestNextPulse
]

{ #category : #'other handlers' }
BlSpaceEventListener >> swipeEvent: anEvent [
]

{ #category : #'keyboard handlers' }
BlSpaceEventListener >> textInputEvent: anEvent [
	self keyboardProcessor processTextInput: anEvent
]

{ #category : #'touch handlers' }
BlSpaceEventListener >> touchDownEvent: anEvent [
	self touchProcessor handleTouchDown: anEvent
]

{ #category : #'touch handlers' }
BlSpaceEventListener >> touchMoveEvent: anEvent [
	self touchProcessor handleTouchMove: anEvent
]

{ #category : #accessing }
BlSpaceEventListener >> touchProcessor [
	^ self space touchProcessor
]

{ #category : #'touch handlers' }
BlSpaceEventListener >> touchUpEvent: anEvent [
	self touchProcessor handleTouchUp: anEvent
]

{ #category : #'other handlers' }
BlSpaceEventListener >> zoomEvent: anEvent [
]
