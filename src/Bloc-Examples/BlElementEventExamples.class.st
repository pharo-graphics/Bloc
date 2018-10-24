"
I contain examples of different BlElementEvents
"
Class {
	#name : #BlElementEventExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Event'
}

{ #category : #examples }
BlElementEventExamples >> addedToParent [
	<gtExample>
	| wasAdded parent child container |
	
	wasAdded := 0.
	
	child := self child.
	child addEventHandlerOn: BlElementAddedToParentEvent do: [ wasAdded := wasAdded + 1 ].
	
	parent := self parent.
	container := self container.
	
	"is sent only when child is added to the parent"
	parent addChild: child.
	"will not be sent when adding parent to a container"
	container addChild: parent.
	
	self assert: wasAdded equals: 1.
	^ container
]

{ #category : #examples }
BlElementEventExamples >> addedToSuperParent [
	<gtExample>
	| parent child container events |
	
	events := OrderedCollection new.
	
	child := self child.
	child addEventHandlerOn: BlElementAddedToSuperParentEvent do: [ :anEvent | events add: anEvent ].
	
	parent := self parent.
	container := self container.
	
	"is sent when child is added to the parent"
	parent addChild: child.
	"will also be sent when adding parent to a container"
	container addChild: parent.
	
	self assert: events size equals: 2.
	self assert: events first addedElement equals: child.
	self assert: events second addedElement equals: parent.

	^ container
]

{ #category : #examples }
BlElementEventExamples >> backgroundChanged [
	<gtExample>
	| backgroundChanged element |
	backgroundChanged := 0.
	
	element := self child.
	element addEventHandlerOn: BlElementBackgroundChangedEvent do: [ backgroundChanged := backgroundChanged + 1 ].

	element background: Color blue.
	self assert: backgroundChanged equals: 1.
	
	^ element
]

{ #category : #examples }
BlElementEventExamples >> borderChanged [
	<gtExample>
	| borderChanged element |
	borderChanged := 0.
	
	element := self child.
	element addEventHandlerOn: BlElementBorderChangedEvent do: [ borderChanged := borderChanged + 1 ].

	element border: (BlBorder builder paint: Color gray; width: 5; build).
	self assert: borderChanged equals: 1.
	
	^ element
]

{ #category : #'instance creation' }
BlElementEventExamples >> child [
	<gtExample>

	^ BlElement new
		size: 100@75;
		background: Color red
]

{ #category : #'instance creation' }
BlElementEventExamples >> container [
	<gtExample>

	^ BlElement new
		size: 500@400;
		border: (BlBorder builder dashed width: 2; paint: Color red; build)
]

{ #category : #examples }
BlElementEventExamples >> extentChanged [
	<gtExample>
	| extentChanged element |
	extentChanged := 0.
	
	element := self child.
	"make sure initial extent is computed"
	element forceLayout.	
	element addEventHandlerOn: BlElementExtentChangedEvent do: [ extentChanged := extentChanged + 1 ].

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

{ #category : #examples }
BlElementEventExamples >> layoutChanged [
	<gtExample>
	| layoutChanged element |
	layoutChanged := 0.
	
	element := self child.
	element addEventHandlerOn: BlElementLayoutChangedEvent do: [ layoutChanged := layoutChanged + 1 ].

	element layout: BlLinearLayout vertical.
	self assert: layoutChanged equals: 1.

	^ element
]

{ #category : #'instance creation' }
BlElementEventExamples >> parent [
	<gtExample>

	^ BlElement new
		size: 400@300;
		background: (Color gray alpha: 0.3)
]

{ #category : #examples }
BlElementEventExamples >> positionChanged [
	<gtExample>
	| positionChanged parent child |
	
	positionChanged := 0.
	
	child := self child.
	parent := self parent.
	parent addChild: child.
	parent forceLayout.
	
	child addEventHandlerOn: BlElementPositionChangedEvent do: [ positionChanged := positionChanged + 1 ].
	
	child relocate: child position + (20@20).
	child forceLayout.
	self assert: positionChanged equals: 1.

	"relocating child to the same position should not trigger an event"
	child relocate: child position.
	child forceLayout.
	self assert: positionChanged equals: 1.

	^ parent
]

{ #category : #examples }
BlElementEventExamples >> removedFromParent [
	<gtExample>
	| wasRemoved parent child container |
	
	wasRemoved := 0.
	
	child := self child.
	child addEventHandlerOn: BlElementRemovedEvent do: [ wasRemoved := wasRemoved + 1 ].
	
	parent := self parent.
	container := self container.

	parent addChild: child.
	container addChild: parent.
	
	container removeChild: parent.
	parent removeChild: child.
	
	self assert: wasRemoved equals: 1.
	^ container
]
