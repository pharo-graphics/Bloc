"
I am an event simulation driver for Bloc elements.

I provide a high-level API to simulate user interactions such as mouse clicks, double clicks, drags, mouse movements, mouse wheel scrolling, keystrokes, text input, and modifier keys (Shift, Ctrl, Alt, Cmd).

### Key Responsibilities
- **Realistic Event Generation**: Constructs low-level UI events (`BlMouseDownEvent`, `BlMouseUpEvent`, `BlMouseMoveEvent`, `BlKeyDownEvent`, `BlKeyUpEvent`, `BlTextInputEvent`, `BlMouseWheelEvent`) with timestamps and modifier state.
- **Pulse Synchronization**: Enqueues events directly into the target's `BlHostSpace` event queue and calls `space settle` so that event handlers, layout changes, and frame passes complete before returning control to the caller.
- **Stateful Modifiers**: Maintains modifier state (`modifiers`) and pressed keys (`pressedKeys`) across multi-step sequences.

### Typical Usage

```smalltalk
""1. Mouse Clicks & Movements""
aButton eventSimulator click.
aButton eventSimulator doubleClick.
aButton eventSimulator secondaryClick.
aButton eventSimulator mouseMoveAt: 50 @ 50.
aButton eventSimulator dragBy: 100 @ 0.

""2. Keyboard & Text Input""
aTextField requestFocus.
aTextField eventSimulator textInput: 'Hello Bloc'.
aTextField eventSimulator keyPress: KeyboardKey return.

""3. Modifiers (Shift / Ctrl / Alt / Cmd)""
anElement eventSimulator
	shiftDown;
	click;
	shiftUp.
```

### Invariants
- The target element must be attached to an opened space before simulating events.
"
Class {
	#name : #BlEventSimulator,
	#superclass : #Object,
	#instVars : [
		'target',
		'modifiers',
		'pressedKeys'
	],
	#category : #'Bloc-Simulation'
}

{ #category : #'instance creation' }
BlEventSimulator class >> forElement: anElement [
	"Create an event simulator targeting the given element."

	^ self new
		target: anElement;
		yourself
]

{ #category : #simulation }
BlEventSimulator >> altDown [
	"Press and hold the Alt modifier key for subsequent simulated events."

	modifiers alt: true
]

{ #category : #simulation }
BlEventSimulator >> altUp [
	"Release the Alt modifier key."

	modifiers alt: false
]

{ #category : #simulation }
BlEventSimulator >> click [
	"Perform a primary click at the center of the target element."

	self clickButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> clickButton: aButton [
	"Perform a click (mouse down and mouse up) with the specified button at the center of the target element."

	| aPosition |
	aPosition := self positionInside.
	self events: {
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> clickOutside [
	"Simulate a primary click event outside of the target element's bounds."

	| aPosition |
	aPosition := self positionOutside.
	self events: {
		(BlMouseDownEvent primary position: aPosition; yourself).
		(BlMouseUpEvent primary position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> cmdDown [
	"Press and hold the Command modifier key for subsequent simulated events."

	modifiers cmd: true
]

{ #category : #simulation }
BlEventSimulator >> cmdUp [
	"Release the Command modifier key."

	modifiers cmd: false
]

{ #category : #simulation }
BlEventSimulator >> ctrlDown [
	"Press and hold the Control modifier key for subsequent simulated events."

	modifiers ctrl: true
]

{ #category : #simulation }
BlEventSimulator >> ctrlUp [
	"Release the Control modifier key."

	modifiers ctrl: false
]

{ #category : #simulation }
BlEventSimulator >> doubleClick [
	"Perform a primary double click at the center of the target element."

	self doubleClickButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> doubleClickButton: aButton [
	"Perform a double click (two consecutive mouse down/up sequences) with the specified button at the center of the target element."

	| aPosition |
	aPosition := self positionInside.
	self events: {
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself).
		((BlMouseDownEvent button: aButton) position: aPosition; yourself).
		((BlMouseUpEvent button: aButton) position: aPosition; yourself) }
]

{ #category : #simulation }
BlEventSimulator >> dragBy: aPoint [
	"Simulate a drag event starting from the center of the target element by the specified delta point."

	self dragByAll: { aPoint }
]

{ #category : #simulation }
BlEventSimulator >> dragByAll: aSequenceOfPoints [
	"Simulate a drag in the center of the target element by performing
	mouse down, mouse move across a sequence of delta vectors, and mouse up."

	| currentPosition |
	currentPosition := self positionInside.

	self events:
		(Array streamContents: [ :stream |
			stream nextPut:
				(BlMouseDownEvent primary
					position: currentPosition;
					yourself).

			aSequenceOfPoints do: [ :each |
				| aDelta |
				aDelta :=
					(target localBoundsToGlobal:
						(BlBounds origin: 0.0 @ 0.0 extent: each)) extent.
				currentPosition := currentPosition + aDelta.
				stream nextPut:
					(BlMouseMoveEvent primary
						position: currentPosition;
						delta: aDelta;
						yourself) ].

			stream nextPut:
				(BlMouseUpEvent primary
					position: currentPosition;
					yourself) ])
]

{ #category : #simulation }
BlEventSimulator >> event: anEvent [
	"Simulate a single low-level space event."

	self events: { anEvent }
]

{ #category : #simulation }
BlEventSimulator >> events: aCollectionOfEvents [
	"I simulate a given sequence of low-level space UI events such as MouseUp/MouseDown or keyboard.
	Events are enqueued into the host space and synchronized with the space's pulse loop."

	| aSpace |
	self 
		assert: [ target isAttachedToSceneGraph ]
		description: [ 'Elements must be attached to a space before simulating events.' ].
	
	aSpace := target space.
	aSpace host denyPulseProcess.

	aCollectionOfEvents do: [ :anEvent |
		anEvent fillFromTime: aSpace time.
		anEvent isUIEvent ifTrue: [
			modifiers isEmpty ifFalse: [
				anEvent modifiers: modifiers copy ] ] ].

	aSpace hasHostSpace ifFalse: [
		aSpace settle.
		aSpace hasHostSpace ifFalse: [
			self error: 'You can''t simulate events if you didn''t add the element to a space and sent #show to it.' ] ].

	aCollectionOfEvents do: [ :anEvent |
		aSpace enqueueEvent: anEvent ].

	aSpace settle
]

{ #category : #initialization }
BlEventSimulator >> initialize [

	super initialize.
	modifiers := BlKeyModifiers new.
	pressedKeys := Set new
]

{ #category : #testing }
BlEventSimulator >> isKeyPressed: aKeyboardKey [
	"Return true if the specified keyboard key is currently pressed."

	^ pressedKeys includes: aKeyboardKey
]

{ #category : #simulation }
BlEventSimulator >> keyDown: aKeyboardKey [
	"Simulate a key down event for the specified keyboard key."

	pressedKeys add: aKeyboardKey.
	self events: { BlKeyDownEvent new key: aKeyboardKey; yourself }
]

{ #category : #simulation }
BlEventSimulator >> keyPress: aKeyboardKey [
	"Simulate a full key press (key down followed by key up) for the specified keyboard key."

	pressedKeys add: aKeyboardKey.
	self events: {
		(BlKeyDownEvent new key: aKeyboardKey; yourself).
		(BlKeyUpEvent new key: aKeyboardKey; yourself) }.
	pressedKeys remove: aKeyboardKey ifAbsent: [ ]
]

{ #category : #simulation }
BlEventSimulator >> keyUp: aKeyboardKey [
	"Simulate a key up event for the specified keyboard key."

	pressedKeys remove: aKeyboardKey ifAbsent: [ ].
	self events: { BlKeyUpEvent new key: aKeyboardKey; yourself }
]

{ #category : #accessing }
BlEventSimulator >> modifiers [
	"Return the current key modifiers state."

	^ modifiers
]

{ #category : #simulation }
BlEventSimulator >> mouseDown [
	"Perform a primary mouse down event at the center of the target element."

	self mouseDownButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> mouseDownAt: aPoint [
	"Simulate a primary mouse down event at the specified space position."

	self events: { BlMouseDownEvent primary position: aPoint }
]

{ #category : #simulation }
BlEventSimulator >> mouseDownButton: aButton [
	"Simulate a mouse down event with the specified mouse button at the center of the target element."

	| aPosition |
	aPosition := self positionInside.
	self events: {
		((BlMouseDownEvent button: aButton)
			position: aPosition;
			yourself) }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveAt: aPoint [
	"Simulate a mouse move event to the specified space position."

	self events: { BlMouseMoveEvent primary position: aPoint; delta: 0 @ 0; yourself }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveBy: aPoint [
	"Simulate a mouse move from the center of the target element by the given delta vector."

	| aPosition |
	aPosition := self positionInside + aPoint.
	self events: {
		BlMouseMoveEvent primary
			position: aPosition;
			delta: aPoint;
			yourself }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveFrom: aFromPoint to: aToPoint [
	"Simulate a mouse move event from one space position to another."

	self events: { BlMouseMoveEvent primary position: aToPoint; delta: (aToPoint - aFromPoint) }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveInside [
	"Simulate a mouse move event to a position within the target element's bounds."

	| aPosition |
	aPosition := self positionInside.
	self events: { BlMouseMoveEvent primary position: aPosition }
]

{ #category : #simulation }
BlEventSimulator >> mouseMoveOutside [
	"Simulate a mouse move event to a position outside of the target element's bounds."

	| aPosition |
	aPosition := self positionOutside.
	self events: { BlMouseMoveEvent primary position: aPosition }
]

{ #category : #simulation }
BlEventSimulator >> mouseUp [
	"Perform a primary mouse up event at the center of the target element."

	self mouseUpButton: BlMouseButton primary
]

{ #category : #simulation }
BlEventSimulator >> mouseUpAt: aPoint [
	"Simulate a primary mouse up event at the specified space position."

	self event: (BlMouseUpEvent primary position: aPoint; yourself)
]

{ #category : #simulation }
BlEventSimulator >> mouseUpButton: aButton [
	"Simulate a mouse up event with the specified mouse button at the center of the target element."

	| aPosition |
	aPosition := self positionInside.
	self events: {
		((BlMouseUpEvent button: aButton)
			position: aPosition;
			yourself) }
]

{ #category : #simulation }
BlEventSimulator >> mouseWheelBy: aBlVector [
	"Simulate a mouse wheel scroll event centered on the target element by the specified vector."

	| aPosition aBlocEvent |
	aPosition := self positionInside.
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.

	self event: aBlocEvent
]

{ #category : #simulation }
BlEventSimulator >> positionInside [
	"Return a space position inside of the target element's bounds."

	target space settle.

	^ target bounds inSpace bounds center
]

{ #category : #simulation }
BlEventSimulator >> positionOutside [
	"Return a space position outside of the target element's bounds."

	target space settle.

	^ target bounds inSpace bounds bottomRight + 1
]

{ #category : #simulation }
BlEventSimulator >> secondaryClick [
	"Simulate a secondary (right) click in the center of the target element."

	self clickButton: BlMouseButton secondary
]

{ #category : #simulation }
BlEventSimulator >> shiftDown [
	"Press and hold the Shift modifier key for subsequent simulated events."

	modifiers shift: true
]

{ #category : #simulation }
BlEventSimulator >> shiftUp [
	"Release the Shift modifier key."

	modifiers shift: false
]

{ #category : #accessing }
BlEventSimulator >> target [
	"Return the target element for event simulation."

	^ target
]

{ #category : #accessing }
BlEventSimulator >> target: anElement [
	"Set the target element for event simulation."

	target := anElement
]

{ #category : #simulation }
BlEventSimulator >> textInput: aString [
	"Simulate a text input event with the specified string."

	self event: (BlTextInputEvent new text: aString; yourself)
]
