Class {
	#name : #BlEventSimulator,
	#superclass : #Object,
	#instVars : [
		'target',
		'space',
		'mousePosition',
		'modifiers',
		'pressedKeys'
	],
	#category : #'Bloc-Simulation'
}

{ #category : #'instance creation' }
BlEventSimulator class >> forTarget: anObject [
	^ self new
		target: anObject;
		yourself
]

{ #category : #'instance creation' }
BlEventSimulator class >> on: anObject [
	^ self forTarget: anObject
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> locationInside: anElement [
	^ (self forTarget: anElement) locationInside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> locationOutside: anElement [
	^ (self forTarget: anElement) locationOutside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOn: anElement [
	^ (self forTarget: anElement) simulateClick
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOn: anElement button: aButton [
	^ (self forTarget: anElement) simulateClickButton: aButton
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOutside: anElement [
	^ (self forTarget: anElement) simulateClickOutside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDoubleClickOn: anElement [
	^ (self forTarget: anElement) simulateDoubleClick
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDragOn: anElement by: aBlVector [
	^ (self forTarget: anElement) simulateDragBy: aBlVector
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	^ (self forTarget: anElement) simulateDragByAll: aSequenceOfBlVectors
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateEvent: anEvent on: anElement [
	^ (self forTarget: anElement) simulateEvent: anEvent
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateEvents: aCollectionOfEvents on: anElement [
	^ (self forTarget: anElement) simulateEvents: aCollectionOfEvents
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	^ (self forTarget: anElement) simulateKeyDown: aKeyboardKey
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	^ (self forTarget: anElement) simulateKeyUp: aKeyboardKey
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseDownOn: anElement [
	^ (self forTarget: anElement) simulateMouseDown
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseDownOn: anElement at: aPoint [
	^ (self forTarget: anElement) simulateMouseDownAt: aPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveInside: anElement [
	^ (self forTarget: anElement) simulateMouseMoveInside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOn: anElement at: aPoint [
	^ (self forTarget: anElement) simulateMouseMoveAt: aPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	^ (self forTarget: anElement) simulateMouseMoveFrom: aFromPoint to: aToPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOutside: anElement [
	^ (self forTarget: anElement) simulateMouseMoveOutside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseUpOn: anElement [
	^ (self forTarget: anElement) simulateMouseUp
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseUpOn: anElement at: aPoint [
	^ (self forTarget: anElement) simulateMouseUpAt: aPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseWheelOn: anElement by: aBlVector [
	^ (self forTarget: anElement) simulateMouseWheelBy: aBlVector
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateSecondaryClickOn: anElement [
	^ (self forTarget: anElement) simulateSecondaryClick
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateTextInput: aString on: aBlElement [
	^ (self forTarget: aBlElement) simulateTextInput: aString
]

{ #category : #initialization }
BlEventSimulator >> initialize [
	super initialize.
	modifiers := BlKeyModifiers new.
	pressedKeys := Set new
]

{ #category : #accessing }
BlEventSimulator >> target: anObject [
	target := anObject.
	(target isKindOf: BlSpace)
		ifTrue: [ space := target ]
		ifFalse: [ 
			target isAttachedToSceneGraph ifTrue: [ space := target space ] ]
]

{ #category : #accessing }
BlEventSimulator >> target [
	^ target
]

{ #category : #accessing }
BlEventSimulator >> space [
	^ space
]

{ #category : #accessing }
BlEventSimulator >> mousePosition [
	^ mousePosition
]

{ #category : #accessing }
BlEventSimulator >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlEventSimulator >> pressedKeys [
	^ pressedKeys
]

{ #category : #simulation }
BlEventSimulator >> locationInside [
	"Return a random space location inside of target bounds"	
	| theBounds aPosition |
	
	target topMostParent forceLayout.
	theBounds := target bounds inSpace bounds.
	aPosition := theBounds atRandom.
		
	self
		assert: [ theBounds containsPoint: aPosition ]
		description: [ 'Point({1}) must be inside of the bounds({2})' format: { aPosition . theBounds } ].
		
	^ aPosition
]

{ #category : #simulation }
BlEventSimulator >> locationOutside [
	"Return a random space location outside of target bounds"	
	| theBounds aPosition |
	
	target topMostParent forceLayout.
	theBounds := target bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height asInteger atRandom).
		theBounds bottomLeft + (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height asInteger atRandom).
	} atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition
]

{ #category : #simulation }
BlEventSimulator >> simulateClick [
	"Simulate a click event in the middle of target element by
	performing mouse down and mouse up events in a sequence"
	^ self simulateClickButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> simulateClickButton: aButton [
	"Simulate a click event in the middle of target element by
	performing mouse down and mouse up events in a sequence."
	| aPosition |

	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.
	
	self
		simulateEvents: {
			((BlMouseDownEvent button: aButton) position: aPosition; yourself).
			((BlMouseUpEvent button: aButton) position: aPosition; yourself) }.
		
	^ aPosition
]

{ #category : #simulation }
BlEventSimulator >> simulateClickOutside [
	"Simulate a click event outside of target bounds by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	aPosition := self locationOutside.
	mousePosition := aPosition.
	self
		simulateEvents: {
			(BlMouseDownEvent primary position: aPosition; yourself).
			(BlMouseUpEvent primary position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> simulateDoubleClick [
	"Simulate a double click event in the middle of target element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.
	self
		simulateEvents: {
			(BlMouseDownEvent primary position: aPosition; yourself).
			(BlMouseUpEvent primary position: aPosition; yourself).
			(BlMouseDownEvent primary position: aPosition; yourself).
			(BlMouseUpEvent primary position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> simulateDragBy: aBlVector [
	"Simulate a drag event in the middle of target element by a vector"
	| aPosition aDelta |
	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	aDelta := (target localBoundsToGlobal:
		(BlBounds origin: 0.0 @ 0.0 extent: aBlVector)) extent.
	mousePosition := aPosition + aDelta.
	self
		simulateEvents: {
			(BlMouseDownEvent primary position: aPosition; yourself).
			(BlMouseMoveEvent primary position: mousePosition; delta: aDelta; yourself).
			(BlMouseUpEvent primary position: mousePosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> simulateDragByAll: aSequenceOfBlVectors [
	"Simulate a drag in the center of target element by performing
	mouse down, mouse move, and mouse up events in a sequence of vectors."
	| aPosition aDelta |
	target forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.

	self simulateEvent: (BlMouseDownEvent primary position: mousePosition; yourself).

	aSequenceOfBlVectors do: [ :each |
		aDelta := (target localBoundsToGlobal:
			(BlBounds origin: 0.0 @ 0.0 extent: each)) extent.
		mousePosition := mousePosition + aDelta.
		self simulateEvent: (BlMouseMoveEvent primary position: mousePosition; delta: aDelta; yourself) ].

	self simulateEvent: (BlMouseUpEvent primary position: mousePosition; delta: aDelta; yourself)
]

{ #category : #simulation }
BlEventSimulator >> simulateEvent: anEvent [
	"Simulate a single event"
	self simulateEvents: { anEvent }
]

{ #category : #simulation }
BlEventSimulator >> simulateEvents: aCollectionOfEvents [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard."
	| aSpace topMostElement |
	target isAttachedToSceneGraph
		ifTrue: [ aSpace := target space ]
		ifFalse: [
			topMostElement := target topMostParent.
			aSpace := BlSpace new.
			aSpace root addChild: topMostElement ].

	(target isKindOf: BlElement) ifTrue: [
		target requestFocus ].

	aCollectionOfEvents do: [ :anEvent |
		anEvent fillFromTime: aSpace time.
		(anEvent isKindOf: BlUIEvent) ifTrue: [
			modifiers isEmpty ifFalse: [
				anEvent modifiers: modifiers copy ] ] ].

	aSpace pulse.
	aSpace
		dispatchTimeEvent: BlSpaceEventsProcessedEvent
		during: [
			aCollectionOfEvents do: [ :anEvent |
				aSpace dispatchEvent: anEvent ] ].
	aSpace pulse.

	topMostElement ifNotNil: [ topMostElement removeFromParent ]
]

{ #category : #simulation }
BlEventSimulator >> simulateKeyDown: aKeyboardKey [
	"Simulate a key down event"
	pressedKeys add: aKeyboardKey.
	self simulateEvents: { BlKeyDownEvent new key: aKeyboardKey; yourself }
]

{ #category : #simulation }
BlEventSimulator >> simulateKeyUp: aKeyboardKey [
	"Simulate a key up event"
	pressedKeys remove: aKeyboardKey ifAbsent: [ ].
	self simulateEvents: { BlKeyUpEvent new key: aKeyboardKey; yourself }
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseDown [
	"Simulate a mouse down event in the middle of target element"
	| aPosition |
	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.
	self simulateEvents: { BlMouseDownEvent primary position: aPosition }
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseDownAt: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"
	mousePosition := aPoint.
	self simulateEvents: { BlMouseDownEvent primary position: aPoint }
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseMoveInside [
	"Simulate a mouse move event at a random location within target's bounds"
	| aPosition |
	aPosition := self locationInside.
	mousePosition := aPosition.
	self simulateEvents: { BlMouseMoveEvent primary position: aPosition }
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseMoveAt: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	| aDelta |
	aDelta := mousePosition ifNil: [ 0 @ 0 ] ifNotNil: [ aPoint - mousePosition ].
	mousePosition := aPoint.
	self simulateEvents: { BlMouseMoveEvent primary position: aPoint; delta: aDelta; yourself }
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseMoveFrom: aFromPoint to: aToPoint [
	"Simulate a mouse move event from a point to a point in the space"
	mousePosition := aToPoint.
	self simulateEvents: { BlMouseMoveEvent primary position: aToPoint; delta: (aToPoint - aFromPoint) }
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseMoveOutside [
	"Simulate a mouse move event at a random location outside of target's bounds"
	| aPosition |
	aPosition := self locationOutside.
	mousePosition := aPosition.
	self simulateEvents: { BlMouseMoveEvent primary position: aPosition }
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseUp [
	"Simulate a mouse up event in the middle of target element"
	| aPosition |
	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.
	self simulateEvent: (BlMouseUpEvent primary position: aPosition; yourself)
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseUpAt: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"
	mousePosition := aPoint.
	self simulateEvent: (BlMouseUpEvent primary position: aPoint; yourself)
]

{ #category : #simulation }
BlEventSimulator >> simulateMouseWheelBy: aBlVector [
	"Simulate a mouse wheel event in the middle of target element"
	| aPosition aBlocEvent |
	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.
	self simulateEvent: aBlocEvent.
	^ aPosition
]

{ #category : #simulation }
BlEventSimulator >> simulateSecondaryClick [
	"Simulate a secondary click event in the middle of target element by
	performing mouse down and mouse up events in a sequence"
	^ self simulateClickButton: BlMouseButton secondary
]

{ #category : #simulation }
BlEventSimulator >> simulateTextInput: aString [
	"Simulate a text input event"
	self simulateEvent: (BlTextInputEvent new text: aString; yourself)
]

{ #category : #'virtual device' }
BlEventSimulator >> mouseDown [
	"Perform a mouse down event at the current mouse position (defaulting to the center of target if nil)"
	^ self mouseDownButton: BlMouseButton primary
]

{ #category : #'virtual device' }
BlEventSimulator >> mouseDownButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	mousePosition := aPosition.
	self simulateEvents: { ((BlMouseDownEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #'virtual device' }
BlEventSimulator >> mouseUp [
	"Perform a mouse up event at the current mouse position"
	^ self mouseUpButton: BlMouseButton primary
]

{ #category : #'virtual device' }
BlEventSimulator >> mouseUpButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	mousePosition := aPosition.
	self simulateEvents: { ((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #'virtual device' }
BlEventSimulator >> mouseMoveBy: aPoint [
	"Move the mouse by a delta relative to current position"
	| oldPosition newPosition |
	oldPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	newPosition := oldPosition + aPoint.
	mousePosition := newPosition.
	self simulateEvents: { BlMouseMoveEvent primary position: newPosition; delta: aPoint; yourself }
]

{ #category : #'virtual device' }
BlEventSimulator >> shiftDown [
	modifiers shift: true
]

{ #category : #'virtual device' }
BlEventSimulator >> shiftUp [
	modifiers shift: false
]

{ #category : #'virtual device' }
BlEventSimulator >> ctrlDown [
	modifiers ctrl: true
]

{ #category : #'virtual device' }
BlEventSimulator >> ctrlUp [
	modifiers ctrl: false
]

{ #category : #'virtual device' }
BlEventSimulator >> altDown [
	modifiers alt: true
]

{ #category : #'virtual device' }
BlEventSimulator >> altUp [
	modifiers alt: false
]

{ #category : #'virtual device' }
BlEventSimulator >> cmdDown [
	modifiers cmd: true
]

{ #category : #'virtual device' }
BlEventSimulator >> cmdUp [
	modifiers cmd: false
]

{ #category : #'virtual device' }
BlEventSimulator >> click [
	"Perform a click at the current mouse position"
	^ self clickButton: BlMouseButton primary
]

{ #category : #'virtual device' }
BlEventSimulator >> clickButton: aButton [
	"Perform a click (mouse down and mouse up) at the current mouse position"
	self mouseDownButton: aButton.
	self mouseUpButton: aButton
]

{ #category : #'virtual device' }
BlEventSimulator >> doubleClick [
	"Perform a double click at the current mouse position"
	^ self doubleClickButton: BlMouseButton primary
]

{ #category : #'virtual device' }
BlEventSimulator >> doubleClickButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	mousePosition := aPosition.
	self simulateEvents: {
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself).
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #'virtual device' }
BlEventSimulator >> keyPress: aKeyboardKey [
	"Simulate a key down followed by key up event"
	self simulateKeyDown: aKeyboardKey.
	self simulateKeyUp: aKeyboardKey
]

{ #category : #'virtual device' }
BlEventSimulator >> isKeyPressed: aKeyboardKey [
	^ pressedKeys includes: aKeyboardKey
]
