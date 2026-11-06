"
I contain examples of space related events

"
Class {
	#name : #BlSpaceEventTest,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Tests-Events'
}

{ #category : #running }
BlSpaceEventTest >> setUp [

	super setUp.

	space :=
		BlSpace new
		  host: BlHeadlessHost default;
		  yourself
]

{ #category : #running }
BlSpaceEventTest >> tearDown [

	space ifNotNil: [ space close; settle ].

	super tearDown
]

{ #category : #tests }
BlSpaceEventTest >> testEnqueueEventAndDequeue [
	| event dequeued |
	self deny: space hasEvents.

	event := BlMouseDownEvent new.
	space enqueueEvent: event.
	self assert: space hasEvents.

	dequeued := space dequeuedEvents.
	self deny: space hasEvents.
	self assert: dequeued size equals: 1.
	self assert: dequeued first == event
]

{ #category : #tests }
BlSpaceEventTest >> testEnqueuedMouseEventKeepsItsScreenPosition [

	| event |
	event := BlMouseDownEvent primary
		         position: 30 @ 40;
		         screenPosition: 5 @ 6;
		         yourself.
	space enqueueEvent: event.
	self assert: event screenPosition equals: 5 @ 6
]

{ #category : #tests }
BlSpaceEventTest >> testEnqueuedMouseEventWithoutPositionStaysWithoutScreenPosition [

	| event |
	event := BlMouseDownEvent new.
	space enqueueEvent: event.
	self assert: event screenPosition isNil
]

{ #category : #tests }
BlSpaceEventTest >> testEnqueuedMouseEventWithoutScreenPositionGetsOne [

	| event |
	event := BlMouseDownEvent primary
		         position: 30 @ 40;
		         yourself.
	space enqueueEvent: event.
	self assert: event screenPosition equals: (space position ifNil: [ 0 @ 0 ]) + (30 @ 40)
]

{ #category : #tests }
BlSpaceEventTest >> testEventsClearedOnHostSpaceClose [
	space show; settle.
	space enqueueEvent: BlMouseDownEvent new.
	self assert: space hasEvents.

	space close; settle.
	self deny: space hasEvents
]

{ #category : #tests }
BlSpaceEventTest >> testMouseEventMadeByAConstructorHasNoScreenPosition [
	"The constructors do not know the position of the window on the desktop, so they leave the screen position unknown instead of inventing 0@0"

	self assert: (BlMouseDownEvent primary
			 position: 30 @ 40;
			 yourself) screenPosition isNil.
	self assert: (BlMouseUpEvent primary
			 position: 30 @ 40;
			 yourself) screenPosition isNil.
	self assert: (BlMouseMoveEvent primary
			 position: 30 @ 40;
			 yourself) screenPosition isNil
]

{ #category : #tests }
BlSpaceEventTest >> testSpaceClosed [

	| count |
	count := 0.

	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ count := count + 1 ].

	space show; settle.
	self assert: count equals: 0.

	space close; settle.
	self assert: count equals: 1
]

{ #category : #tests }
BlSpaceEventTest >> testSpaceShown [

	| count |
	count := 0.

	space
		addEventHandlerOn: BlSpaceShownEvent
		do: [ count := count + 1 ].

	space show; settle.
	self assert: count equals: 1.

	space close; settle.
	self assert: count equals: 1
]
