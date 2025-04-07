Class {
	#name : #BlElementEventTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Event'
}

{ #category : #running }
BlElementEventTest >> newChild [

	^ BlElement new
		  size: 100 @ 75;
		  background: Color red;
		  yourself
]

{ #category : #running }
BlElementEventTest >> newContainer [

	^ BlElement new
		  size: 500 @ 400;
		  border:
				(BlBorder builder dashed
				   width: 2;
				   paint: Color red;
				   build);
		  yourself
]

{ #category : #running }
BlElementEventTest >> newParent [

	^ BlElement new
		  size: 400 @ 300;
		  background: (Color gray alpha: 0.3);
		  yourself
]

{ #category : #tests }
BlElementEventTest >> testAddedToParent [

	| wasAdded parent child container |
	wasAdded := 0.

	child := self newChild.
	child
		addEventHandlerOn: BlElementAddedToParentEvent
		do: [ wasAdded := wasAdded + 1 ].

	parent := self newParent.
	container := self newContainer.

	"is sent only when child is added to the parent"
	parent addChild: child.
	"will not be sent when adding parent to a container"
	container addChild: parent.

	self assert: wasAdded equals: 1
]

{ #category : #tests }
BlElementEventTest >> testBackgroundChanged [

	| backgroundChanged element |
	backgroundChanged := 0.

	element := self newChild.
	element
		addEventHandlerOn: BlElementBackgroundChangedEvent
		do: [ backgroundChanged := backgroundChanged + 1 ].

	element background: Color blue.
	self assert: backgroundChanged equals: 1
]

{ #category : #tests }
BlElementEventTest >> testBorderChanged [

	| borderChanged element |
	borderChanged := 0.

	element := self newChild.
	element
		addEventHandlerOn: BlElementBorderChangedEvent
		do: [ borderChanged := borderChanged + 1 ].

	element border: (BlBorder builder
			 paint: Color gray;
			 width: 5;
			 build).
	self assert: borderChanged equals: 1
]

{ #category : #tests }
BlElementEventTest >> testExtentChanged [

	| extentChanged element |
	extentChanged := 0.

	element := self newChild.
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
	self assert: extentChanged equals: 1
]

{ #category : #tests }
BlElementEventTest >> testExtentChangedChangingWithTheSameSizeDoesNotRaiseEvent [

	| extentChanged element |
	extentChanged := 0.
	element := self newChild.
	"make sure initial extent is computed"
	element forceLayout.
	element
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ extentChanged := extentChanged + 1 ].

	element size: element extent.
	element forceLayout.
	self assert: extentChanged equals: 0
]

{ #category : #tests }
BlElementEventTest >> testLayoutChanged [

	| layoutChanged element |
	layoutChanged := 0.

	element := self newChild.
	element
		addEventHandlerOn: BlElementLayoutChangedEvent
		do: [ layoutChanged := layoutChanged + 1 ].

	element layout: BlLinearLayout vertical.
	self assert: layoutChanged equals: 1
]

{ #category : #tests }
BlElementEventTest >> testPositionChanged [

	| positionChanged parent child |
	positionChanged := 0.

	child := self newChild.
	parent := self newParent.
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
	self assert: positionChanged equals: 1
]

{ #category : #tests }
BlElementEventTest >> testPositionChangedRelocatingOnSamePositionDoesNotRaiseEvent [

	| positionChanged parent child |
	positionChanged := 0.

	child := self newChild.
	parent := self newParent.
	parent addChild: child.
	parent forceLayout.

	child
		addEventHandlerOn: BlElementPositionChangedEvent
		do: [ positionChanged := positionChanged + 1 ].


	child position: child position.
	child forceLayout.
	self assert: positionChanged equals: 0
]

{ #category : #tests }
BlElementEventTest >> testRemovedFromParent [

	| wasRemoved parent child container |
	wasRemoved := 0.
	child := self newChild.
	child
		addEventHandlerOn: BlElementRemovedFromParentEvent
		do: [ wasRemoved := wasRemoved + 1 ].
	parent := self newParent.
	container := self newContainer.

	parent addChild: child.
	container addChild: parent.

	container removeChild: parent.
	parent removeChild: child.

	self assert: wasRemoved equals: 1
]
