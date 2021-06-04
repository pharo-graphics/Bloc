"
I contain examples various aspects of event dispatching and handling mechanism such as custom events, event simulation etc

"
Class {
	#name : #BlEventExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'instance creation' }
BlEventExamples >> blueElement [
	<gtExample>
	
	^ BlElement new
		background: Color blue
]

{ #category : #'events - filter' }
BlEventExamples >> childConsumesEventWithHandler [
	<gtExample>
	| parent child clicks |
	
	clicks := OrderedCollection new.
	
	parent := self redElement.
	parent relocate: 100@100.
	parent size: 100@100.
	parent addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent consumed: true. clicks add: Color red ].
	
	child := self blueElement.
	child relocate: 10@10.
	child size: 50@50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent consumed: true. clicks add: Color blue ].
	
	parent addChild: child.
	
	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color blue } asOrderedCollection.
	
	^ parent
]

{ #category : #'events - filter' }
BlEventExamples >> childDoesNotConsumeEventWithHandler [
	<gtExample>
	| parent child clicks |
	
	clicks := OrderedCollection new.
	
	parent := self redElement.
	parent relocate: 100@100.
	parent size: 100@100.
	parent addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent consumed: true. clicks add: Color red ].
	
	child := self blueElement.
	child relocate: 10@10.
	child size: 50@50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent consumed: false. clicks add: Color blue ].
	
	parent addChild: child.
	
	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color blue . Color red } asOrderedCollection.
	
	^ parent
]

{ #category : #'instance creation' }
BlEventExamples >> customEvent [
	<gtExample>
	
	^ BlExampleCustomEvent new payload: 'Hello world!'
]

{ #category : #'instance creation' }
BlEventExamples >> customEventListener [
	<gtExample>
	
	^ BlEventHandler
		on: BlExampleCustomEvent
		do: [ :aCustomEvent | aCustomEvent consumed: true ]
]

{ #category : #'instance creation' }
BlEventExamples >> customEventTarget [
	<gtExample>
	
	^ BlExampleCustomEventTarget new
]

{ #category : #'events - custom' }
BlEventExamples >> fireCustomEventWithCustomTarget [
	<gtExample>
	| event target handler |
	
	event := self customEvent.
	target := self customEventTarget.
	handler := self customEventListener.
	
	target addEventHandler: handler.
	target dispatchEvent: event.
	
	self assert: event isConsumed.
	
	^ target
]

{ #category : #'instance creation' }
BlEventExamples >> grayElement [
	<gtExample>
	
	^ BlElement new
		background: Color veryVeryLightGray
]

{ #category : #'events - filter' }
BlEventExamples >> parentWithEventFilter [
	<gtExample>
	| parent child clicks |
	
	clicks := OrderedCollection new.
	
	parent := self redElement.
	parent relocate: 100@100.
	parent size: 100@100.
	parent addEventFilterOn: BlClickEvent do: [ :anEvent | anEvent consumed: true. clicks add: Color red ].
	
	child := self blueElement.
	child relocate: 10@10.
	child size: 50@50.
	child addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent consumed: true. clicks add: Color blue ].
	
	parent addChild: child.
	
	BlSpace simulateClickOn: child.
	self assert: clicks equals: { Color red } asOrderedCollection.
	
	^ parent
]

{ #category : #'instance creation' }
BlEventExamples >> redElement [
	<gtExample>
	
	^ BlElement new
		background: Color red
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClick [
	<gtExample>
	| element mouseDown mouseUp click |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 0@0.
	
	mouseDown := mouseUp := click := 0.
	
	element addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	element addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: element.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ element
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClickOnChildInDisabledParent [
	<gtExample>
	| parent red mouseDown mouseUp click |
	
	parent := self grayElement.
	parent size: 300@300.
	"make parent element be unresponsive to mouse events"
	parent preventMouseEvents.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.

	parent addChildren: { red }.

	mouseDown := mouseUp := click := 0.
	
	red addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	red addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	red addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: red.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ parent
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClickOnChildInParentPreventingChildren [
	<gtExample>
	| parent red childMouseDown childMouseUp childClick parentMouseDown parentMouseUp parentClick |
	
	parent := self grayElement.
	parent size: 300@300.
	"make parent element and children be unresponsive to mouse events"
	parent preventChildrenMouseEvents.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.

	parent addChildren: { red }.

	childMouseDown := childMouseUp := childClick := 0.
	red addEventHandlerOn: BlMouseDownEvent do: [ childMouseDown := childMouseDown + 1 ].
	red addEventHandlerOn: BlMouseUpEvent do: [ childMouseUp := childMouseUp + 1 ].
	red addEventHandlerOn: BlClickEvent do: [ childClick := childClick + 1 ].
	
	parentMouseDown := parentMouseUp := parentClick := 0.
	parent addEventHandlerOn: BlMouseDownEvent do: [ parentMouseDown := parentMouseDown + 1 ].
	parent addEventHandlerOn: BlMouseUpEvent do: [ parentMouseUp := parentMouseUp + 1 ].
	parent addEventHandlerOn: BlClickEvent do: [ parentClick := parentClick + 1 ].
	
	BlSpace simulateClickOn: red.
	
	self assert: childMouseDown equals: 0.
	self assert: childMouseUp equals: 0.
	self assert: childClick equals: 0.
	
	self assert: parentMouseDown equals: 1.
	self assert: parentMouseUp equals: 1.
	self assert: parentClick equals: 1.
	
	^ parent
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClickOnChildInUnresponsiveParent [
	<gtExample>
	| parent red mouseDown mouseUp click |
	
	parent := self grayElement.
	parent size: 300@300.
	"make parent element and children be unresponsive to mouse events"
	parent preventMeAndChildrenMouseEvents.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.

	parent addChildren: { red }.

	mouseDown := mouseUp := click := 0.
	
	red addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	red addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	red addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: red.
	
	self assert: mouseDown equals: 0.
	self assert: mouseUp equals: 0.
	self assert: click equals: 0.
	
	^ parent
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClickOnOverlapped [
	"I simulate a click on the element which is overlapped by another element.
	Since element above does not consume click events, one below should succesfully
	handle mouse down/up and click events"
	
	"<gtExample>" "<- fails becaus we need 'elevation based' event handling (Bloc-Compositor)"
	| container blue red mouseDown mouseUp click |
	
	container := self grayElement.
	container size: 300@300.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.
	
	"blue is below the red element"
	blue := self blueElement.
	blue size: 100@100.
	blue opacity: 0.2.
	
	container addChildren: { blue . red }.
	
	mouseDown := mouseUp := click := 0.
	
	blue addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	blue addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	blue addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: blue.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ container
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClickOnTransformedAndRelocated [
	<gtExample>
	| element mouseDown mouseUp click |

	element := self simulateClick.
	element size: 10@10.
	element relocate: 500@300.
	element transform
		scaleBy: 15@15;
		translateBy: (300@0) negated;
		rotateBy: 30;
		rotateBy: 15;
		apply.
	
	mouseDown := mouseUp := click := 0.
	
	element addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	element addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: element.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ element
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClickOnUnresponsiveOverlapped [
	"I simulate a click on the element which is overlapped by another element
	which is unresponsive to mouse events (e.g. transparent to mouse events).
	Since element above does not consume click events, one below should succesfully
	handle mouse down/up and click events"
	<gtExample>
	| container blue red mouseDown mouseUp click |
	
	container := self grayElement.
	container size: 300@300.
	
	red := self redElement.
	red size: 200@200.
	red opacity: 0.2.
	"make red element unresponsive to mouse events"
	red preventMouseEvents.

	"blue is below the red element"
	blue := self blueElement.
	blue size: 100@100.
	blue opacity: 0.2.
	
	container addChildren: { blue . red }.
	
	mouseDown := mouseUp := click := 0.
	
	blue addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	blue addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	blue addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOn: blue.
	
	self assert: mouseDown equals: 1.
	self assert: mouseUp equals: 1.
	self assert: click equals: 1.
	
	^ container
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateClickOutside [
	<gtExample>
	| element mouseDown mouseUp click |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 100@100.
	
	mouseDown := mouseUp := click := 0.
	
	element addEventHandlerOn: BlMouseDownEvent do: [ mouseDown := mouseDown + 1 ].
	element addEventHandlerOn: BlMouseUpEvent do: [ mouseUp := mouseUp + 1 ].
	element addEventHandlerOn: BlClickEvent do: [ click := click + 1 ].
	
	BlSpace simulateClickOutside: element.
	
	self assert: mouseDown equals: 0.
	self assert: mouseUp equals: 0.
	self assert: click equals: 0.
	
	^ element
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateMouseMoveInside [
	<gtExample>
	<noTest>
	| element mouseMove mouseEnter |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 100@100.
	
	mouseMove := mouseEnter := 0.
	
	element addEventHandlerOn: BlMouseMoveEvent do: [ mouseMove := mouseMove + 1 ].
	element addEventHandlerOn: BlMouseEnterEvent do: [ mouseEnter := mouseEnter + 1 ].
	
	BlSpace simulateMouseMoveInside: element.

	self assert: mouseMove equals: 1.
	self assert: mouseEnter equals: 1.
	
	^ element
]

{ #category : #'events - simulation' }
BlEventExamples >> simulateMouseMoveOutside [
	<gtExample>
	| element mouseLeave mouseMove mouseEnter |
	
	element := self blueElement.
	element size: 100@100.
	element relocate: 100@100.
	
	mouseLeave := mouseMove := mouseEnter := 0.
	
	element addEventHandlerOn: BlMouseMoveEvent do: [ mouseMove := mouseMove + 1 ].
	element addEventHandlerOn: BlMouseEnterEvent do: [ mouseEnter := mouseEnter + 1 ].
	element addEventHandlerOn: BlMouseLeaveEvent do: [ mouseLeave := mouseLeave + 1 ].
	
	BlSpace simulateMouseMoveOutside: element.

	self assert: mouseMove equals: 0.
	self assert: mouseEnter equals: 0.
	self assert: mouseLeave equals: 0.
	
	^ element
]
