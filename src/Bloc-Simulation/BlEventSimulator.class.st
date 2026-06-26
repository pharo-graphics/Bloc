Class {
	#name : #BlEventSimulator,
	#superclass : #Object,
	#category : #'Bloc-Simulation'
}

{ #category : #'debug - simulation' }
BlEventSimulator class >> locationInside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := theBounds atRandom.
		
	self
		assert: [ theBounds containsPoint: aPosition ]
		description: [ 'Point({1}) must be inside of the bounds({2})' format: { aPosition . theBounds } ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> locationOutside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height asInteger atRandom).
		theBounds bottomLeft + (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height asInteger atRandom).
	}	atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOn: anElement [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"

	^ self simulateClickOn: anElement button: BlMouseButton primary
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOn: anElement button: aButton [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence."

	| aPosition |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			(BlMouseDownEvent button: aButton) position: aPosition; yourself.
			(BlMouseUpEvent button: aButton) position: aPosition; yourself }
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateClickOutside: anElement [
	"Simulate a click event in outside of a given element by
	performing mouse down and mouse up events in a sequence"

	| aPosition |
	aPosition := self locationOutside: anElement.
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition;
					 yourself) }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDoubleClickOn: anElement [
	"Simulate a double click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"

	| aPosition |
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	"we simulate a double click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition;
					 yourself) }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDragOn: anElement by: aBlVector [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"

	| aPosition aDelta |
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	aDelta :=
		(anElement localBoundsToGlobal:
			(BlBounds origin: 0.0 @ 0.0 extent: aBlVector)) extent.

	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseMoveEvent primary
					 position: aPosition + aDelta;
					 delta: aDelta;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition + aDelta;
					 yourself) }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	"Simulate a drag in the center of a given element by
	performing mouse down, mouse move, and mouse up events."

	| aPosition aDelta |
	anElement forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvent:
			(BlMouseDownEvent primary
				position: aPosition;
				yourself)
		on: anElement.

	aSequenceOfBlVectors do: [ :each |
		aDelta := (anElement localBoundsToGlobal:
			(BlBounds origin: 0.0@0.0 extent: each)) extent.
		aPosition := aPosition + aDelta.
		self
			simulateEvent:
				(BlMouseMoveEvent primary
					position: aPosition "+ aDelta";
					delta: aDelta;
					yourself)
			on: anElement ].

	self
		simulateEvent:
			(BlMouseUpEvent primary
				position: aPosition "+ aDelta";
				delta: aDelta;
				yourself)
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateEvent: anEvent on: anElement [
	"I simulate a given low level space UI event such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element.
	Note: I create a temporary space if provided element does not have one. if you need to simulate
	a sequence of dependent events it is better to use #simulateEvents:on: directy"

	self simulateEvents: { anEvent } on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateEvents: aCollectionOfEvents on: anElement [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element"

	| aSpace topMostElement |
	anElement isAttachedToSceneGraph
		ifTrue: [ aSpace := anElement space ]
		ifFalse: [
			topMostElement := anElement topMostParent.
			aSpace := BlSpace new.
			aSpace root addChild: topMostElement ].

	aCollectionOfEvents do: [ :anEvent |
		anEvent fillFromTime: aSpace time ].

	aSpace pulse.
	aSpace
		dispatchTimeEvent: BlSpaceEventsProcessedEvent
		during: [
			aCollectionOfEvents do: [ :anEvent |
				aSpace dispatchEvent: anEvent ] ].
	aSpace pulse.

	topMostElement ifNotNil: [ topMostElement removeFromParent ]
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	"Simulate a key down event"

	self
		simulateEvents: { BlKeyDownEvent new key: aKeyboardKey; yourself }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	"Simulate a key up event"

	self
		simulateEvents: { BlKeyUpEvent new key: aKeyboardKey; yourself }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseDownOn: anElement [
	"Simulate a mouse down event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseDownEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseDownOn: anElement at: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseDownEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveInside: anElement [
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	aPosition := self locationInside: anElement.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOn: anElement at: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary
			position: aToPoint;
			delta: (aToPoint - aFromPoint)  }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseMoveOutside: anElement [
	"Simulate a mouse move event at a random location outside of element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	aPosition := self locationOutside: anElement.
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseUpOn: anElement [
	"Simulate a mouse up event in the middle of a given element"

	| aPosition |
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvent:
			(BlMouseUpEvent primary
				 position: aPosition;
				 yourself)
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseUpOn: anElement at: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"

	self
		simulateEvent:
			(BlMouseUpEvent primary
				 position: aPoint;
				 yourself)
		on: anElement
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateMouseWheelOn: anElement by: aBlVector [
	"Simulate a mouse wheel event in the middle of a given element"
	| aPosition aBlocEvent |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"Bloc event"
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.
	
	self
		simulateEvent: aBlocEvent
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateSecondaryClickOn: anElement [
	"Simulate a secondary click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	
	^ self simulateClickOn: anElement button: BlMouseButton secondary
]

{ #category : #'debug - simulation' }
BlEventSimulator class >> simulateTextInput: aString on: aBlElement [

	self
		simulateEvent: (BlTextInputEvent new
				 text: aString;
				 yourself)
		on: aBlElement
]
