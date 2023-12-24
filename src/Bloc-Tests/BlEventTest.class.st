"
I have been automatically converted and probably manually tweaked from BlEventExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlEventTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests'
}

{ #category : #fixture }
BlEventTest >> simulateClickOnOverlapped [
	"I simulate a click on the element which is overlapped by another element.
	Since element above does not consume click events, one below should succesfully
	handle mouse down/up and click events"

	| container blue red mouseDown mouseUp click |
	container := self testGrayElement.
	container size: 300 @ 300.

	red := self testRedElement.
	red size: 200 @ 200.
	red opacity: 0.2.

	"blue is below the red element"
	blue := self testBlueElement.
	blue size: 100 @ 100.
	blue opacity: 0.2.

	container addChildren: {
			blue.
			red }.

	mouseDown := mouseUp := click := 0.

	blue
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	blue addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	blue addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].

	BlSpace simulateClickOn: blue.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.

	^ container
]

{ #category : #tests }
BlEventTest >> testBlueElement [

	<sampleInstance>
	<demo>
	^ BlElement new background: Color blue
]

{ #category : #tests }
BlEventTest >> testChildConsumesEventWithHandler [

	<sampleInstance>
	<demo>
	| parent child clicks |
	clicks := OrderedCollection new.

	parent := self testRedElement.
	parent position: 100 @ 100.
	parent size: 100 @ 100.
	parent addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		clicks add: Color red ].

	child := self testBlueElement.
	child position: 10 @ 10.
	child size: 50 @ 50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		clicks add: Color blue ].

	parent addChild: child.

	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color blue } asOrderedCollection.

	^ parent
]

{ #category : #tests }
BlEventTest >> testChildDoesNotConsumeEventWithHandler [

	<sampleInstance>
	| parent child clicks |
	clicks := OrderedCollection new.

	parent := self testRedElement.
	parent position: 100 @ 100.
	parent size: 100 @ 100.
	parent addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		clicks add: Color red ].

	child := self testBlueElement.
	child position: 10 @ 10.
	child size: 50 @ 50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consumed: false.
		clicks add: Color blue ].

	parent addChild: child.

	BlSpace simulateClickOn: child.
	self assert: clicks equals: {
			Color blue.
			Color red } asOrderedCollection.

	^ parent
]

{ #category : #tests }
BlEventTest >> testCustomEvent [

	<sampleInstance>
	^ BlExampleCustomEvent new payload: 'Hello world!'
]

{ #category : #tests }
BlEventTest >> testCustomEventListener [

	<sampleInstance>
	^ BlEventHandler
		  on: BlExampleCustomEvent
		  do: [ :aCustomEvent | aCustomEvent consumed: true ]
]

{ #category : #tests }
BlEventTest >> testCustomEventTarget [

	<sampleInstance>
	^ BlExampleCustomEventTarget new
]

{ #category : #tests }
BlEventTest >> testFireCustomEventWithCustomTarget [

	<sampleInstance>
	| event target handler |
	event := self testCustomEvent.
	target := self testCustomEventTarget.
	handler := self testCustomEventListener.

	target addEventHandler: handler.
	target dispatchEvent: event.

	self assert: event isConsumed.

	^ target
]

{ #category : #tests }
BlEventTest >> testGrayElement [

	<sampleInstance>
	<demo>
	^ BlElement new background: Color veryVeryLightGray
]

{ #category : #tests }
BlEventTest >> testParentWithEventFilter [

	<sampleInstance>
	<demo>
	| parent child clicks |
	clicks := OrderedCollection new.

	parent := self testRedElement.
	parent position: 100 @ 100.
	parent size: 100 @ 100.
	parent addEventFilterOn: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		clicks add: Color red ].

	child := self testBlueElement.
	child position: 10 @ 10.
	child size: 50 @ 50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		clicks add: Color blue ].

	parent addChild: child.

	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color red } asOrderedCollection.

	^ parent
]

{ #category : #tests }
BlEventTest >> testRedElement [

	<sampleInstance>
	<demo>
	^ BlElement new background: Color red
]

{ #category : #tests }
BlEventTest >> testSimulateClick [

	<sampleInstance>
	| element mouseDown mouseUp click |
	element := self testBlueElement.
	element size: 100 @ 100.
	element position: 0 @ 0.

	mouseDown := mouseUp := click := 0.

	element
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	element
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].

	BlSpace simulateClickOn: element.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.

	^ element
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnChildInDisabledParent [

	<sampleInstance>
	<demo>
	| parent red mouseDown mouseUp click |
	parent := self testGrayElement.
	parent size: 300 @ 300.
	"make parent element be unresponsive to mouse events"
	parent preventMouseEvents.

	red := self testRedElement.
	red size: 200 @ 200.
	red opacity: 0.2.

	parent addChildren: { red }.

	mouseDown := mouseUp := click := 0.

	red
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	red addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	red addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].

	BlSpace simulateClickOn: red.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.

	^ parent
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnChildInParentPreventingChildren [

	<sampleInstance>
	| parent red childMouseDown childMouseUp childClick parentMouseDown parentMouseUp parentClick |
	parent := self testGrayElement.
	parent size: 300 @ 300.
	"make parent element and children be unresponsive to mouse events"
	parent preventChildrenMouseEvents.

	red := self testRedElement.
	red size: 200 @ 200.
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
	self assert: parentClick equals: 1.

	^ parent
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnChildInUnresponsiveParent [

	<sampleInstance>
	| parent red mouseDown mouseUp click |
	parent := self testGrayElement.
	parent size: 300 @ 300.
	"make parent element and children be unresponsive to mouse events"
	parent preventMeAndChildrenMouseEvents.

	red := self testRedElement.
	red size: 200 @ 200.
	red opacity: 0.2.

	parent addChildren: { red }.

	mouseDown := mouseUp := click := 0.

	red
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	red addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	red addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].

	BlSpace simulateClickOn: red.

	self assert: mouseDown equals: 0.
	self assert: mouseUp equals: 0.
	self assert: click equals: 0.

	^ parent
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnTransformedAndRelocated [

	<sampleInstance>
	<demo>
	| element mouseDown mouseUp click |
	element := self testSimulateClick.
	element size: 10 @ 10.
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
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].

	BlSpace simulateClickOn: element.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.

	^ element
]

{ #category : #tests }
BlEventTest >> testSimulateClickOnUnresponsiveOverlapped [
	"I simulate a click on the element which is overlapped by another element
	which is unresponsive to mouse events (e.g. transparent to mouse events).
	Since element above does not consume click events, one below should succesfully
	handle mouse down/up and click events"

	<sampleInstance>
	<demo>
	| container blue red mouseDown mouseUp click |
	container := self testGrayElement.
	container size: 300 @ 300.

	red := self testRedElement.
	red size: 200 @ 200.
	red opacity: 0.2.
	"make red element unresponsive to mouse events"
	red preventMouseEvents.

	"blue is below the red element"
	blue := self testBlueElement.
	blue size: 100 @ 100.
	blue opacity: 0.2.

	container addChildren: {
			blue.
			red }.

	mouseDown := mouseUp := click := 0.

	blue
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	blue addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	blue addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].

	BlSpace simulateClickOn: blue.

	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.

	^ container
]

{ #category : #tests }
BlEventTest >> testSimulateClickOutside [

	<sampleInstance>
	| element mouseDown mouseUp click |
	element := self testBlueElement.
	element size: 100 @ 100.
	element position: 100 @ 100.

	mouseDown := mouseUp := click := 0.

	element
		addEventHandlerOn: BlMouseDownEvent
		do: [ mouseDown := mouseDown + 1 ].
	element
		addEventHandlerOn: BlMouseUpEvent
		do: [ mouseUp := mouseUp + 1 ].
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].

	BlSpace simulateClickOutside: element.

	self assert: mouseDown equals: 0.
	self assert: mouseUp equals: 0.
	self assert: click equals: 0.

	^ element
]

{ #category : #tests }
BlEventTest >> testSimulateMouseMoveInside [

	<sampleInstance>
	<noTest>
	| element mouseMove mouseEnter |
	element := self testBlueElement.
	element size: 100 @ 100.
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
	self assert: mouseEnter equals: 1.

	^ element
]

{ #category : #tests }
BlEventTest >> testSimulateMouseMoveOutside [

	<sampleInstance>
	| element mouseLeave mouseMove mouseEnter |
	element := self testBlueElement.
	element size: 100 @ 100.
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
	self assert: mouseLeave equals: 0.

	^ element
]
