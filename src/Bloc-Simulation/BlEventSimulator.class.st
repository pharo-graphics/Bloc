Class {
	#name : #BlEventSimulator,
	#superclass : #Object,
	#instVars : [
		'target',
		'space',
		'mousePosition',
		'modifiers',
		'pressedKeys',
		'shouldFocus',
		'timeout'
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
BlEventSimulator class >> on: anObject [
	^ self forElement: anObject
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
BlEventSimulator >> click [
	"Perform a click at the current mouse position (defaulting to the center of target if nil)"
	^ self clickButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> clickButton: aButton [
	"Perform a click (mouse down and mouse up) at the current mouse position"
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target space waitPulse.
		mousePosition := target bounds inSpace center ].
	self events: {
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
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
BlEventSimulator >> cmdDown [
	modifiers cmd: true
]

{ #category : #simulation }
BlEventSimulator >> cmdUp [
	modifiers cmd: false
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
BlEventSimulator >> doubleClick [
	"Perform a double click at the current mouse position (defaulting to the center of target if nil)"
	^ self doubleClickButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> doubleClickButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target space waitPulse.
		mousePosition := target bounds inSpace center ].
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
	target space waitPulse.
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
	| aPosition aDelta eventsList |
	target space waitPulse.
	aPosition := target bounds inSpace center.
	mousePosition := aPosition.
	eventsList := OrderedCollection new.

	eventsList add: (BlMouseDownEvent primary position: mousePosition; yourself).

	aSequenceOfBlVectors do: [ :each |
		aDelta := (target localBoundsToGlobal:
			(BlBounds origin: 0.0 @ 0.0 extent: each)) extent.
		mousePosition := mousePosition + aDelta.
		eventsList add: (BlMouseMoveEvent primary position: mousePosition; delta: aDelta; yourself) ].

	eventsList add: (BlMouseUpEvent primary position: mousePosition; yourself).

	self events: eventsList
]

{ #category : #accessing }
BlEventSimulator >> element: anElement [
	target := anElement.
	anElement isAttachedToSceneGraph ifTrue: [ space := anElement space ].
	shouldFocus := true
]

{ #category : #simulation }
BlEventSimulator >> event: anEvent [
	"Simulate a single event"
	self events: { anEvent }
]

{ #category : #simulation }
BlEventSimulator >> events: aCollectionOfEvents [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard."
	| aSpace |
	self 
		assert: [ target isAttachedToSceneGraph ]
		description: [ 'Elements must be attached to a space before simulating events.' ].
	
	aSpace := target space.

	shouldFocus ifTrue: [ target requestFocus ].

	aCollectionOfEvents do: [ :anEvent |
		anEvent fillFromTime: aSpace time.
		anEvent isUIEvent ifTrue: [
			modifiers isEmpty ifFalse: [
				anEvent modifiers: modifiers copy ] ] ].

	[ aSpace isOpened and: [ aSpace hasHostSpace ] ] whileFalse: [
		aSpace universe hasDeferredActions
			ifTrue: [ aSpace universe tryToRunDeferredActions ]
			ifFalse: [
				aSpace isOpened
					ifTrue: [ Processor yield ]
					ifFalse: [ self error: 'You can''t simulate events if you didn''t add the element to a space and sent #show to it.' ] ] ].

	aCollectionOfEvents do: [ :anEvent |
		aSpace enqueueEvent: anEvent ].

	aSpace waitPulseFor: timeout.

]

{ #category : #initialization }
BlEventSimulator >> initialize [
	super initialize.
	modifiers := BlKeyModifiers new.
	pressedKeys := Set new.
	shouldFocus := false.
	timeout := 500 milliSeconds
]

{ #category : #testing }
BlEventSimulator >> isKeyPressed: aKeyboardKey [
	^ pressedKeys includes: aKeyboardKey
]

{ #category : #simulation }
BlEventSimulator >> keyDown: aKeyboardKey [
	"Simulate a key down event"
	pressedKeys add: aKeyboardKey.
	self events: { BlKeyDownEvent new key: aKeyboardKey; yourself }
]

{ #category : #simulation }
BlEventSimulator >> keyPress: aKeyboardKey [
	"Simulate a key down followed by key up event"
	pressedKeys add: aKeyboardKey.
	self events: {
		(BlKeyDownEvent new key: aKeyboardKey; yourself).
		(BlKeyUpEvent new key: aKeyboardKey; yourself) }.
	pressedKeys remove: aKeyboardKey ifAbsent: [ ]
]

{ #category : #simulation }
BlEventSimulator >> keyUp: aKeyboardKey [
	"Simulate a key up event"
	pressedKeys remove: aKeyboardKey ifAbsent: [ ].
	self events: { BlKeyUpEvent new key: aKeyboardKey; yourself }
]

{ #category : #simulation }
BlEventSimulator >> locationInside [
	"Return a space location inside of target bounds"	

	target space waitPulse.

	^ target bounds inSpace bounds center
]

{ #category : #simulation }
BlEventSimulator >> locationOutside [
	"Return a space location outside of target bounds"	

	target space waitPulse.

	^ target bounds inSpace bounds bottomRight + 1
]

{ #category : #accessing }
BlEventSimulator >> modifiers [
	^ modifiers
]

{ #category : #simulation }
BlEventSimulator >> mouseDown [
	"Perform a mouse down event at the current mouse position (defaulting to the center of target if nil)"
	^ self mouseDownButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> mouseDownAt: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"
	mousePosition := aPoint.
	self events: { BlMouseDownEvent primary position: aPoint }
]

{ #category : #simulation }
BlEventSimulator >> mouseDownButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target space waitPulse.
		mousePosition := target bounds inSpace center ].
	self events: { ((BlMouseDownEvent button: aButton) position: aPosition; yourself) }
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
BlEventSimulator >> mouseMoveBy: aPoint [
	"Move the mouse by a delta relative to current position"
	| oldPosition newPosition |
	oldPosition := mousePosition ifNil: [ 
		target space waitPulse.
		target bounds inSpace center ].
	newPosition := oldPosition + aPoint.
	mousePosition := newPosition.
	self events: { BlMouseMoveEvent primary position: newPosition; delta: aPoint; yourself }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveFrom: aFromPoint to: aToPoint [
	"Simulate a mouse move event from a point to a point in the space"
	mousePosition := aToPoint.
	self events: { BlMouseMoveEvent primary position: aToPoint; delta: (aToPoint - aFromPoint) }
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
BlEventSimulator >> mouseMoveOutside [
	"Simulate a mouse move event at a random location outside of target's bounds"
	| aPosition |
	aPosition := self locationOutside.
	mousePosition := aPosition.
	self events: { BlMouseMoveEvent primary position: aPosition }
]

{ #category : #accessing }
BlEventSimulator >> mousePosition [
	^ mousePosition
]

{ #category : #simulation }
BlEventSimulator >> mouseUp [
	"Perform a mouse up event at the current mouse position (defaulting to the center of target if nil)"
	^ self mouseUpButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> mouseUpAt: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"
	mousePosition := aPoint.
	self event: (BlMouseUpEvent primary position: aPoint; yourself)
]

{ #category : #simulation }
BlEventSimulator >> mouseUpButton: aButton [
	| aPosition |
	aPosition := mousePosition ifNil: [ 
		target space waitPulse.
		mousePosition := target bounds inSpace center ].
	self events: { ((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> mouseWheelBy: aBlVector [
	"Simulate a mouse wheel event in the middle of target element"
	| aPosition aBlocEvent |
	target space waitPulse.
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
BlEventSimulator >> shiftDown [
	modifiers shift: true
]

{ #category : #simulation }
BlEventSimulator >> shiftUp [
	modifiers shift: false
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

{ #category : #simulation }
BlEventSimulator >> textInput: aString [
	"Simulate a text input event"
	self event: (BlTextInputEvent new text: aString; yourself)
]

{ #category : #accessing }
BlEventSimulator >> timeout [
	^ timeout
]

{ #category : #accessing }
BlEventSimulator >> timeout: aDuration [
	timeout := aDuration
]
