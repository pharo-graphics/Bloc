Class {
	#name : #BlEventSimulator,
	#superclass : #Object,
	#instVars : [
		'target',
		'space',
		'mousePosition',
		'modifiers',
		'pressedKeys',
		'shouldFocus'
	],
	#category : #'Bloc-Simulation'
}

{ #category : #'instance creation' }
BlEventSimulator class >> forElement: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #'instance creation' }
BlEventSimulator class >> forSpace: aSpace [
	^ self new
		space: aSpace;
		yourself
]

{ #category : #'instance creation' }
BlEventSimulator class >> forElement: anObject [
	"Deprecated fallback"
	self
		deprecated: 'Use forElement: or forSpace: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (anObject class includesBehavior: BlSpace)
		ifTrue: [ self forSpace: anObject ]
		ifFalse: [ self forElement: anObject ]
]

{ #category : #'instance creation' }
BlEventSimulator class >> on: anObject [
	^ self forElement: anObject
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> locationInside: anElement [
	^ (self forElement: anElement) locationInside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> locationOutside: anElement [
	^ (self forElement: anElement) locationOutside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOn: anElement [
	^ (self forElement: anElement) click
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOn: anElement button: aButton [
	^ (self forElement: anElement) clickButton: aButton
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOutside: anElement [
	^ (self forElement: anElement) clickOutside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDoubleClickOn: anElement [
	^ (self forElement: anElement) doubleClick
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDragOn: anElement by: aBlVector [
	^ (self forElement: anElement) dragBy: aBlVector
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	^ (self forElement: anElement) dragByAll: aSequenceOfBlVectors
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateEvent: anEvent on: anElement [
	^ (self forElement: anElement) event: anEvent
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateEvents: aCollectionOfEvents on: anElement [
	^ (self forElement: anElement) events: aCollectionOfEvents
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	^ (self forElement: anElement) keyDown: aKeyboardKey
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	^ (self forElement: anElement) keyUp: aKeyboardKey
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseDownOn: anElement [
	^ (self forElement: anElement) mouseDown
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseDownOn: anElement at: aPoint [
	^ (self forElement: anElement) mouseDownAt: aPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveInside: anElement [
	^ (self forElement: anElement) mouseMoveInside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOn: anElement at: aPoint [
	^ (self forElement: anElement) mouseMoveAt: aPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	^ (self forElement: anElement) mouseMoveFrom: aFromPoint to: aToPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOutside: anElement [
	^ (self forElement: anElement) mouseMoveOutside
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseUpOn: anElement [
	^ (self forElement: anElement) mouseUp
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseUpOn: anElement at: aPoint [
	^ (self forElement: anElement) mouseUpAt: aPoint
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseWheelOn: anElement by: aBlVector [
	^ (self forElement: anElement) mouseWheelBy: aBlVector
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateSecondaryClickOn: anElement [
	^ (self forElement: anElement) secondaryClick
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateTextInput: aString on: aBlElement [
	^ (self forElement: aBlElement) textInput: aString
]

{ #category : #initialization }
BlEventSimulator >> initialize [
	super initialize.
	modifiers := BlKeyModifiers new.
	pressedKeys := Set new.
	shouldFocus := false
]

{ #category : #accessing }
BlEventSimulator >> element: anElement [
	target := anElement.
	anElement isAttachedToSceneGraph ifTrue: [ space := anElement space ].
	shouldFocus := true
]

{ #category : #accessing }
BlEventSimulator >> space: aSpace [
	target := aSpace.
	space := aSpace.
	shouldFocus := false
]

{ #category : #accessing }
BlEventSimulator >> target [
	^ target
]

{ #category : #accessing }
BlEventSimulator >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlEventSimulator >> mousePosition [
	^ mousePosition
]

{ #category : #testing }
BlEventSimulator >> isKeyPressed: aKeyboardKey [
	^ pressedKeys includes: aKeyboardKey
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
		description: [ 'Point must be inside of the bounds' ].
	^ aPosition
]

{ #category : #simulation }
BlEventSimulator >> locationOutside [
	"Return a random space location outside of target bounds"	
	| theBounds aPosition |
	target topMostParent forceLayout.
	theBounds := target bounds inSpace bounds.
	aPosition := theBounds origin - (20 @ 20).
	[ theBounds containsPoint: aPosition ] whileTrue: [ 
		aPosition := (theBounds origin - (100 @ 100)) + (200 @ 200) atRandom ].
	^ aPosition
]

{ #category : #simulation }
BlEventSimulator >> event: anEvent [
	"Simulate a single event"
	self events: { anEvent }
]

{ #category : #simulation }
BlEventSimulator >> events: aCollectionOfEvents [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard."
	| aSpace topMostElement |
	target isAttachedToSceneGraph
		ifTrue: [ aSpace := target space ]
		ifFalse: [
			self
				deprecated: 'Elements must be attached to a space before simulating events.'
				on: '2026-06-26'
				in: 'Bloc'.
			topMostElement := target topMostParent.
			aSpace := BlSpace new.
			aSpace root addChild: topMostElement ].

	shouldFocus ifTrue: [ target requestFocus ].

	aCollectionOfEvents do: [ :anEvent |
		anEvent fillFromTime: aSpace time.
		anEvent isUIEvent ifTrue: [
			modifiers isEmpty ifFalse: [
				anEvent modifiers: modifiers copy ] ] ].

	aSpace pulse.
	aSpace hostSpace
		ifNotNil: [ :aHostSpace |
			aCollectionOfEvents do: [ :anEvent |
				aHostSpace enqueueEvent: anEvent ] ]
		ifNil: [
			aCollectionOfEvents do: [ :anEvent |
				aSpace dispatchEvent: anEvent ] ].
	aSpace pulse.

	topMostElement ifNotNil: [ topMostElement removeFromParent ]
]

{ #category : #simulation }
BlEventSimulator >> click [
	"Perform a click at the current mouse position (defaulting to the center of target if nil)"
	^ self clickButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> clickButton: aButton [
	"Perform a click (mouse down and mouse up) at the current mouse position"
	self mouseDownButton: aButton.
	self mouseUpButton: aButton
]

{ #category : #simulation }
BlEventSimulator >> clickOutside [
	"Simulate a click event outside of target bounds"
	| aPosition |
	aPosition := self locationOutside.
	mousePosition := aPosition.
	self
		events: {
			(BlMouseDownEvent primary position: aPosition; yourself).
			(BlMouseUpEvent primary position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> doubleClick [
	"Perform a double click at the current mouse position (defaulting to the center of target if nil)"
	^ self doubleClickButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> doubleClickButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	mousePosition := aPosition.
	self events: {
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself).
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> dragBy: aBlVector [
	"Simulate a drag event in the middle of target element by a vector"
	| aPosition aDelta |
	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	aDelta := (target localBoundsToGlobal:
		(BlBounds origin: 0.0 @ 0.0 extent: aBlVector)) extent.
	mousePosition := aPosition + aDelta.
	self
		events: {
			(BlMouseDownEvent primary position: aPosition; yourself).
			(BlMouseMoveEvent primary position: mousePosition; delta: aDelta; yourself).
			(BlMouseUpEvent primary position: mousePosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> dragByAll: aSequenceOfBlVectors [
	"Simulate a drag in the center of target element by performing
	mouse down, mouse move, and mouse up events in a sequence of vectors."
	| aPosition aDelta |
	target forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.

	self event: (BlMouseDownEvent primary position: mousePosition; yourself).

	aSequenceOfBlVectors do: [ :each |
		aDelta := (target localBoundsToGlobal:
			(BlBounds origin: 0.0 @ 0.0 extent: each)) extent.
		mousePosition := mousePosition + aDelta.
		self event: (BlMouseMoveEvent primary position: mousePosition; delta: aDelta; yourself) ].

	self event: (BlMouseUpEvent primary position: mousePosition; yourself)
]

{ #category : #simulation }
BlEventSimulator >> keyDown: aKeyboardKey [
	"Simulate a key down event"
	pressedKeys add: aKeyboardKey.
	self events: { BlKeyDownEvent new key: aKeyboardKey; yourself }
]

{ #category : #simulation }
BlEventSimulator >> keyUp: aKeyboardKey [
	"Simulate a key up event"
	pressedKeys remove: aKeyboardKey ifAbsent: [ ].
	self events: { BlKeyUpEvent new key: aKeyboardKey; yourself }
]

{ #category : #simulation }
BlEventSimulator >> mouseDown [
	"Perform a mouse down event at the current mouse position (defaulting to the center of target if nil)"
	^ self mouseDownButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> mouseDownButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	mousePosition := aPosition.
	self events: { ((BlMouseDownEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> mouseDownAt: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"
	mousePosition := aPoint.
	self events: { BlMouseDownEvent primary position: aPoint }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveInside [
	"Simulate a mouse move event at a random location within target's bounds"
	| aPosition |
	aPosition := self locationInside.
	mousePosition := aPosition.
	self events: { BlMouseMoveEvent primary position: aPosition }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveAt: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	| aDelta |
	aDelta := mousePosition ifNil: [ 0 @ 0 ] ifNotNil: [ aPoint - mousePosition ].
	mousePosition := aPoint.
	self events: { BlMouseMoveEvent primary position: aPoint; delta: aDelta; yourself }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveFrom: aFromPoint to: aToPoint [
	"Simulate a mouse move event from a point to a point in the space"
	mousePosition := aToPoint.
	self events: { BlMouseMoveEvent primary position: aToPoint; delta: (aToPoint - aFromPoint) }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveOutside [
	"Simulate a mouse move event at a random location outside of target's bounds"
	| aPosition |
	aPosition := self locationOutside.
	mousePosition := aPosition.
	self events: { BlMouseMoveEvent primary position: aPosition }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveBy: aPoint [
	"Move the mouse by a delta relative to current position"
	| oldPosition newPosition |
	oldPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	newPosition := oldPosition + aPoint.
	mousePosition := newPosition.
	self events: { BlMouseMoveEvent primary position: newPosition; delta: aPoint; yourself }
]

{ #category : #simulation }
BlEventSimulator >> mouseUp [
	"Perform a mouse up event at the current mouse position (defaulting to the center of target if nil)"
	^ self mouseUpButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> mouseUpButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target topMostParent forceLayout.
		target bounds inSpace center ].
	mousePosition := aPosition.
	self events: { ((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> mouseUpAt: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"
	mousePosition := aPoint.
	self event: (BlMouseUpEvent primary position: aPoint; yourself)
]

{ #category : #simulation }
BlEventSimulator >> mouseWheelBy: aBlVector [
	"Simulate a mouse wheel event in the middle of target element"
	| aPosition aBlocEvent |
	target topMostParent forceLayout.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.
	self event: aBlocEvent.
	^ aPosition
]

{ #category : #simulation }
BlEventSimulator >> secondaryClick [
	"Simulate a secondary click event in the middle of target element"
	^ self clickButton: BlMouseButton secondary
]

{ #category : #simulation }
BlEventSimulator >> textInput: aString [
	"Simulate a text input event"
	self event: (BlTextInputEvent new text: aString; yourself)
]

{ #category : #simulation }
BlEventSimulator >> keyPress: aKeyboardKey [
	"Simulate a key down followed by key up event"
	self keyDown: aKeyboardKey.
	self keyUp: aKeyboardKey
]

{ #category : #simulation }
BlEventSimulator >> shiftDown [
	modifiers shift: true
]

{ #category : #simulation }
BlEventSimulator >> shiftUp [
	modifiers shift: false
]

{ #category : #simulation }
BlEventSimulator >> ctrlDown [
	modifiers ctrl: true
]

{ #category : #simulation }
BlEventSimulator >> ctrlUp [
	modifiers ctrl: false
]

{ #category : #simulation }
BlEventSimulator >> altDown [
	modifiers alt: true
]

{ #category : #simulation }
BlEventSimulator >> altUp [
	modifiers alt: false
]

{ #category : #simulation }
BlEventSimulator >> cmdDown [
	modifiers cmd: true
]

{ #category : #simulation }
BlEventSimulator >> cmdUp [
	modifiers cmd: false
]
