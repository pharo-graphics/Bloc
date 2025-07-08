"
I have been automatically converted and probably manually tweaked from BlEventExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlEventTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Events'
}

{ #category : #tests }
BlEventTest >> newBlueElement [

	^ BlElement new
		  background: Color blue;
		  yourself
]

{ #category : #tests }
BlEventTest >> newCustomEvent [

	^ BlMockedEvent new
		  payload: 'Hello world!';
		  yourself
]

{ #category : #tests }
BlEventTest >> newCustomEventListener [

	^ BlEventHandler
		  on: BlMockedEvent
		  do: [ :aCustomEvent | aCustomEvent consume ]
]

{ #category : #tests }
BlEventTest >> newCustomEventTarget [

	^ BlMockedEventTarget new
]

{ #category : #tests }
BlEventTest >> newGrayElement [

	^ BlElement new
		  background: Color veryVeryLightGray;
		  yourself
]

{ #category : #tests }
BlEventTest >> newRedElement [

	^ BlElement new
		  background: Color red;
		  yourself
]

{ #category : #tests }
BlEventTest >> testChildConsumesEventWithHandler [

	| parent child clicks |
	clicks := OrderedCollection new.

	parent := self newRedElement.
	parent position: 100 @ 100.
	parent extent: 100 @ 100.
	parent addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		clicks add: Color red ].

	child := self newBlueElement.
	child position: 10 @ 10.
	child extent: 50 @ 50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		clicks add: Color blue ].

	parent addChild: child.

	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color blue } asOrderedCollection
]

{ #category : #tests }
BlEventTest >> testChildDoesNotConsumeEventWithHandler [

	| parent child clicks |
	clicks := OrderedCollection new.

	parent := self newRedElement.
	parent position: 100 @ 100.
	parent extent: 100 @ 100.
	parent addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		clicks add: Color red ].

	child := self newBlueElement.
	child position: 10 @ 10.
	child extent: 50 @ 50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consumed: false.
		clicks add: Color blue ].

	parent addChild: child.

	BlSpace simulateClickOn: child.
	self
		assert: clicks
		equals: {
			Color blue.
			Color red } asOrderedCollection
]

{ #category : #tests }
BlEventTest >> testFireCustomEventWithCustomTarget [

	| event target handler |
	event := self newCustomEvent.
	target := self newCustomEventTarget.
	handler := self newCustomEventListener.

	target addEventHandler: handler.
	target dispatchEvent: event.

	self assert: event isConsumed
]

{ #category : #tests }
BlEventTest >> testParentWithEventFilter [

	| parent child clicks |
	clicks := OrderedCollection new.

	parent := self newRedElement.
	parent position: 100 @ 100.
	parent extent: 100 @ 100.
	parent addEventFilterOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		clicks add: Color red ].

	child := self newBlueElement.
	child position: 10 @ 10.
	child extent: 50 @ 50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consume.
		clicks add: Color blue ].

	parent addChild: child.

	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color red } asOrderedCollection
]

{ #category : #tests }
BlEventTest >> testRemoveEventHandlerAnsweredByAddEventHandlerOnDo [

	| target handlerA handlerB countA countB |
	target := self newCustomEventTarget.
	countA := countB := 0.

	"Add two handlers that increase a counter on each handled event."
	handlerA :=
		target
			addEventHandlerOn: BlMockedEvent
			do: [ :_ | countA := countA + 1 ].
	handlerB :=
		target
			addEventHandlerOn: BlMockedEvent
			do: [ :_ | countB := countB + 1 ].
	target dispatchEvent: BlMockedEvent new.
	self assert: countA equals: 1.
	self assert: countB equals: 1.

	"After removing handlerA, countA doesn't increase."
	target removeEventHandler: handlerA.
	target dispatchEvent: BlMockedEvent new.
	self assert: countA equals: 1.
	self assert: countB equals: 2
]

{ #category : #tests }
BlEventTest >> testSimulateClick [

	| element mouseDown mouseUp click |
	element := self newBlueElement.
	element extent: 100 @ 100.
	element position: 0 @ 0.

	mouseDown := mouseUp := click := 0.

	element
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	element
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	element
		addEventHandlerOn: BlClickEvent
		do: [ click := click + 1 ].

	BlSpace simulateClickOn: element.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnChildInDisabledParent [

	| parent red mouseDown mouseUp click |
	parent := self newGrayElement.
	parent extent: 300 @ 300.
	"make parent element be unresponsive to mouse events"
	parent preventMouseEvents.

	red := self newRedElement.
	red extent: 200 @ 200.
	red opacity: 0.2.

	parent addChildren: { red }.

	mouseDown := mouseUp := click := 0.

	red
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	red
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	red
		addEventHandlerOn: BlClickEvent
		do: [ click := click + 1 ].

	BlSpace simulateClickOn: red.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnChildInParentPreventingChildren [

	| parent red childMouseDown childMouseUp childClick parentMouseDown parentMouseUp parentClick |
	parent := self newGrayElement.
	parent extent: 300 @ 300.
	"make parent element and children be unresponsive to mouse events"
	parent preventChildrenMouseEvents.

	red := self newRedElement.
	red extent: 200 @ 200.
	red opacity: 0.2.

	parent addChildren: { red }.

	childMouseDown := childMouseUp := childClick := 0.
	red
		addEventHandlerOn: BlMouseDownEvent
		do: [ childMouseDown := childMouseDown + 1 ].
	red
		addEventHandlerOn: BlMouseUpEvent
		do: [ childMouseUp := childMouseUp + 1 ].
	red
		addEventHandlerOn: BlClickEvent
		do: [ childClick := childClick + 1 ].

	parentMouseDown := parentMouseUp := parentClick := 0.
	parent
		addEventHandlerOn: BlMouseDownEvent
		do: [ parentMouseDown := parentMouseDown + 1 ].
	parent
		addEventHandlerOn: BlMouseUpEvent
		do: [ parentMouseUp := parentMouseUp + 1 ].
	parent
		addEventHandlerOn: BlClickEvent
		do: [ parentClick := parentClick + 1 ].

	BlSpace simulateClickOn: red.

	self assert: childMouseDown equals: 0.
	self assert: childMouseUp equals: 0.
	self assert: childClick equals: 0.

	self assert: parentMouseDown equals: 1.
	self assert: parentMouseUp equals: 1.
	self assert: parentClick equals: 1
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnChildInUnresponsiveParent [

	| parent red mouseDown mouseUp click |
	parent := self newGrayElement.
	parent extent: 300 @ 300.
	"make parent element and children be unresponsive to mouse events"
	parent preventMeAndChildrenMouseEvents.

	red := self newRedElement.
	red extent: 200 @ 200.
	red opacity: 0.2.

	parent addChildren: { red }.

	mouseDown := mouseUp := click := 0.

	red
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	red
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	red
		addEventHandlerOn: BlClickEvent
		do: [ click := click + 1 ].

	BlSpace simulateClickOn: red.

	self assert: mouseDown equals: 0.
	self assert: mouseUp equals: 0.
	self assert: click equals: 0
]

{ #category : #fixture }
BlEventTest >> testSimulateClickOnOverlapped [
	"By default, the blue element would be below the red element, but elevation inverts it."

	| container blue red clickOnBlue |
	container := self newGrayElement.
	container extent: 300 @ 300.

	blue := self newBlueElement.
	blue extent: 200 @ 200.
	blue opacity: 0.2.
	blue elevation: (BlGlobalElevation elevation: 10).
	container addChild: blue.

	red := self newRedElement.
	red extent: 200 @ 200.
	red opacity: 0.2.
	red elevation: (BlGlobalElevation elevation: 1).
	container addChild: red.

	clickOnBlue := 0.
	blue
		addEventHandlerOn: BlClickEvent
		do: [ clickOnBlue := clickOnBlue + 1 ].

	BlSpace simulateClickOn: red.

	self assert: clickOnBlue equals: 1
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnTransformedAndRelocated [

	| element mouseDown mouseUp click |
	element := self newBlueElement.
	element extent: 10 @ 10.
	element position: 500 @ 300.
	element transform
		scaleBy: 15 @ 15;
		translateBy: (300 @ 0) negated;
		rotateBy: 30;
		rotateBy: 15;
		apply.

	mouseDown := mouseUp := click := 0.

	element
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	element
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	element
		addEventHandlerOn: BlClickEvent
		do: [ click := click + 1 ].

	BlSpace simulateClickOn: element.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnUnresponsiveOverlapped [
	"I simulate a click on the element which is overlapped by another element
	which is unresponsive to mouse events (e.g. transparent to mouse events).
	Since element above does not consume click events, one below should succesfully
	handle mouse down/up and click events"

	| container blue red mouseDown mouseUp click |
	container := self newGrayElement.
	container extent: 300 @ 300.

	red := self newRedElement.
	red extent: 200 @ 200.
	red opacity: 0.2.
	"make red element unresponsive to mouse events"
	red preventMouseEvents.

	"blue is below the red element"
	blue := self newBlueElement.
	blue extent: 100 @ 100.
	blue opacity: 0.2.

	container addChildren: { blue. red }.

	mouseDown := mouseUp := click := 0.

	blue
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	blue
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	blue
		addEventHandlerOn: BlClickEvent
		do: [ click := click + 1 ].

	BlSpace simulateClickOn: blue.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1
]

{ #category : #tests }
BlEventTest >> testSimulateClickOutside [

	| element mouseDown mouseUp click |
	element := self newBlueElement.
	element extent: 100 @ 100.
	element position: 100 @ 100.

	mouseDown := mouseUp := click := 0.

	element
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	element
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	element
		addEventHandlerOn: BlClickEvent
		do: [ click := click + 1 ].

	BlSpace simulateClickOutside: element.

	self assert: mouseDown equals: 0.
	self assert: mouseUp equals: 0.
	self assert: click equals: 0
]

{ #category : #tests }
BlEventTest >> testSimulateMouseMoveInside [

	| element mouseMove mouseEnter |
	element := self newBlueElement.
	element extent: 100 @ 100.
	element position: 100 @ 100.

	mouseMove := mouseEnter := 0.

	element
		addEventHandlerOn: BlMouseMoveEvent
		do: [ mouseMove := mouseMove + 1 ].
	element
		addEventHandlerOn: BlMouseEnterEvent
		do: [ mouseEnter := mouseEnter + 1 ].

	BlSpace simulateMouseMoveInside: element.

	self assert: mouseMove equals: 1.
	self assert: mouseEnter equals: 1
]

{ #category : #tests }
BlEventTest >> testSimulateMouseMoveOutside [

	| element mouseLeave mouseMove mouseEnter |
	element := self newBlueElement.
	element extent: 100 @ 100.
	element position: 100 @ 100.

	mouseLeave := mouseMove := mouseEnter := 0.

	element
		addEventHandlerOn: BlMouseMoveEvent
		do: [ mouseMove := mouseMove + 1 ].
	element
		addEventHandlerOn: BlMouseEnterEvent
		do: [ mouseEnter := mouseEnter + 1 ].
	element
		addEventHandlerOn: BlMouseLeaveEvent
		do: [ mouseLeave := mouseLeave + 1 ].

	BlSpace simulateMouseMoveOutside: element.

	self assert: mouseMove equals: 0.
	self assert: mouseEnter equals: 0.
	self assert: mouseLeave equals: 0
]
