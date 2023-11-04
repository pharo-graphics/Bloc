"
I have been automatically converted and probably manually tweaked from BlElementEventExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlElementEventTest,
	#superclass : #TestCase,
	#package : 'Bloc',
	#tag : 'UnitedTests-Event'
}

{ #category : #'test seed' }
BlElementEventTest >> child [

	<sampleInstance>
	^ BlElement new
		  size: 100 @ 75;
		  background: Color red
]

{ #category : #'test seed' }
BlElementEventTest >> container [

	<sampleInstance>
	^ BlElement new
		  size: 500 @ 400;
		  border: (BlBorder builder dashed
				   width: 2;
				   paint: Color red;
				   build)
]

{ #category : #'test seed' }
BlElementEventTest >> parent [

	<sampleInstance>
	^ BlElement new
		  size: 400 @ 300;
		  background: (Color gray alpha: 0.3)
]

{ #category : #tests }
BlElementEventTest >> testAddedToParent [

	<sampleInstance>
	| wasAdded parent child container |
	wasAdded := 0.

	child := self child.
	child
		addEventHandlerOn: BlElementAddedToParentEvent
		do: [ wasAdded := wasAdded + 1 ].

	parent := self parent.
	container := self container.

	"is sent only when child is added to the parent"
	parent addChild: child.
	"will not be sent when adding parent to a container"
	container addChild: parent.

	self assert: wasAdded equals: 1.
	^ container
]

{ #category : #tests }
BlElementEventTest >> testBackgroundChanged [

	<sampleInstance>
	| backgroundChanged element |
	backgroundChanged := 0.

	element := self child.
	element
		addEventHandlerOn: BlElementBackgroundChangedEvent
		do: [ backgroundChanged := backgroundChanged + 1 ].

	element background: Color blue.
	self assert: backgroundChanged equals: 1.

	^ element
]

{ #category : #tests }
BlElementEventTest >> testBorderChanged [

	<sampleInstance>
	| borderChanged element |
	borderChanged := 0.

	element := self child.
	element
		addEventHandlerOn: BlElementBorderChangedEvent
		do: [ borderChanged := borderChanged + 1 ].

	element border: (BlBorder builder
			 paint: Color gray;
			 width: 5;
			 build).
	self assert: borderChanged equals: 1.

	^ element
]

{ #category : #tests }
BlElementEventTest >> testExtentChanged [

	<sampleInstance>
	| extentChanged element |
	extentChanged := 0.

	element := self child.
	"make sure initial extent is computed"
	element forceLayout.
	element
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ extentChanged := extentChanged + 1 ].

	"change size and force compute layout"
	element size: element extent * 2.
	element forceLayout.
	self assert: extentChanged equals: 1.

	"requesting the same size should not trigger event"
	element size: element extent.
	element forceLayout.
	self assert: extentChanged equals: 1.

	^ element
]

{ #category : #tests }
BlElementEventTest >> testExtentChangedChangingWithTheSameSizeDoesNotRaiseEvent [

	<sampleInstance>
	| extentChanged element |
	extentChanged := 0.
	element := self child.
	"make sure initial extent is computed"
	element forceLayout.
	element
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ extentChanged := extentChanged + 1 ].

	element size: element extent.
	element forceLayout.
	self assert: extentChanged equals: 0.

	^ element
]

{ #category : #tests }
BlElementEventTest >> testLayoutChanged [

	<sampleInstance>
	| layoutChanged element |
	layoutChanged := 0.

	element := self child.
	element
		addEventHandlerOn: BlElementLayoutChangedEvent
		do: [ layoutChanged := layoutChanged + 1 ].

	element layout: BlLinearLayout vertical.
	self assert: layoutChanged equals: 1.

	^ element
]

{ #category : #tests }
BlElementEventTest >> testPositionChanged [

	<sampleInstance>
	| positionChanged parent child |
	positionChanged := 0.

	child := self child.
	parent := self parent.
	parent addChild: child.
	parent forceLayout.

	child
		addEventHandlerOn: BlElementPositionChangedEvent
		do: [ positionChanged := positionChanged + 1 ].

	child position: child position + (20 @ 20).
	child forceLayout.
	self assert: positionChanged equals: 1.

	"relocating child to the same position should not trigger an event"
	child position: child position.
	child forceLayout.
	self assert: positionChanged equals: 1.

	^ parent
]

{ #category : #tests }
BlElementEventTest >> testPositionChangedRelocatingOnSamePositionDoesNotRaiseEvent [

	<sampleInstance>
	| positionChanged parent child |
	positionChanged := 0.

	child := self child.
	parent := self parent.
	parent addChild: child.
	parent forceLayout.

	child
		addEventHandlerOn: BlElementPositionChangedEvent
		do: [ positionChanged := positionChanged + 1 ].


	child position: child position.
	child forceLayout.
	self assert: positionChanged equals: 0.

	^ parent
]

{ #category : #tests }
BlElementEventTest >> testRemovedFromParent [

	<sampleInstance>
	| wasRemoved parent child container |
	wasRemoved := 0.
	child := self child.
	child
		addEventHandlerOn: BlElementRemovedFromParentEvent
		do: [ wasRemoved := wasRemoved + 1 ].
	parent := self parent.
	container := self container.

	parent addChild: child.
	container addChild: parent.

	container removeChild: parent.
	parent removeChild: child.

	self assert: wasRemoved equals: 1.
	^ container
]
