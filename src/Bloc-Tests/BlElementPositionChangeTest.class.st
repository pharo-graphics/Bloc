"
I contain examples of position change logging functionality
"
Class {
	#name : #BlElementPositionChangeTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Changes'
}

{ #category : #accessing }
BlElementPositionChangeTest >> element [
	<gtExample>

	^ BlElement new
]

{ #category : #accessing }
BlElementPositionChangeTest >> elementTree [
	<gtExample>
	| parent child subChild |

	parent := self element.
	parent size: 200@200.
	parent background: Color blue.
	
	child := self element.
	child size: 150@150.
	child background: Color red.
	
	subChild := self element.
	subChild size: 100@100.
	subChild background: Color green.
	
	child addChild: subChild.
	parent addChild: child.

	^ parent
]

{ #category : #tests }
BlElementPositionChangeTest >> testParentPositionChanged [
	<gtExample>
	|
		parent parentPositionChangedListener parentPositionInSpaceChangedListener parentPositionChanged parentPositionInSpaceChanged
		child childPositionChangedListener childPositionInSpaceChangedListener childPositionChanged childPositionInSpaceChanged
		subChild subChildPositionChangedListener subChildPositionInSpaceChangedListener subChildPositionChanged subChildPositionInSpaceChanged
		anUpdater
	|

	parentPositionChanged := parentPositionInSpaceChanged := 0.
	childPositionChanged := childPositionInSpaceChanged := 0.
	subChildPositionChanged := subChildPositionInSpaceChanged := 0.

	parent := self elementTree.
	parent forceLayout.
	
	child := parent children first.
	subChild := child children first.
	
	parentPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ parentPositionChanged := parentPositionChanged + 1 ].
	parentPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ parentPositionInSpaceChanged := parentPositionInSpaceChanged + 1 ].
		
	childPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ childPositionChanged := childPositionChanged + 1 ].
	childPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ childPositionInSpaceChanged := childPositionInSpaceChanged + 1 ].
		
	subChildPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ subChildPositionChanged := subChildPositionChanged + 1 ].
	subChildPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ subChildPositionInSpaceChanged := subChildPositionInSpaceChanged + 1 ].
	
	self assert: parent position equals: 0@0.
	self assert: child position equals: 0@0.
	self assert: subChild position equals: 0@0.
	
	parent addEventHandler: parentPositionChangedListener.
	parent addEventHandler: parentPositionInSpaceChangedListener.
	
	child addEventHandler: childPositionChangedListener.
	child addEventHandler: childPositionInSpaceChangedListener.
	
	subChild addEventHandler: subChildPositionChangedListener.
	subChild addEventHandler: subChildPositionInSpaceChangedListener.
	
	anUpdater := BlElementBoundsUpdater new.
	"change parent's position directy directly"
	parent position: 50@50 extent: parent extent context: anUpdater.
	
	"notify changed"
	anUpdater commitChanges.

	self assert: parent position equals: 50@50.
	self assert: parentPositionChanged equals: 1.
	self assert: parentPositionInSpaceChanged equals: 1.
	
	self assert: child position equals: 0@0.
	self assert: childPositionChanged equals: 0.
	self assert: childPositionInSpaceChanged equals: 1.
	
	self assert: subChild position equals: 0@0.
	self assert: subChildPositionChanged equals: 0.
	self assert: subChildPositionInSpaceChanged equals: 1.
	
	parent removeEventHandler: parentPositionChangedListener.
	parent removeEventHandler: parentPositionInSpaceChangedListener.
	
	child removeEventHandler: childPositionChangedListener.
	child removeEventHandler: childPositionInSpaceChangedListener.

	subChild removeEventHandler: subChildPositionChangedListener.
	subChild removeEventHandler: subChildPositionInSpaceChangedListener.

	parent position: 0@0 extent: parent extent context: anUpdater.
	
	^ parent
]

{ #category : #tests }
BlElementPositionChangeTest >> testPositionChangeBoundsChange [
	<gtExample>
	| element anUpdater |
	
	element := self element.
	element background: Color blue.
	element size: 100@100.
	element relocate: 0@0.
	element forceLayout.
	
	anUpdater := BlElementBoundsUpdater new.
	
	self assert: element boundsInLocal equals: (0@0 extent: 100@100).
	self assert: element bounds inParent asRectangle equals: (0@0 extent: 100@100).
	
	"As soon as we change position bounds should change too"
	element position: 30@30 extent: element extent context: anUpdater.
	
	self assert: element boundsInLocal equals: (0@0 extent: 100@100).
	self assert: element bounds inParent asRectangle equals: (30@30 extent: 100@100).
	
	"change position and extent at the same time"
	element position: 50@50 extent: 150@150 context: anUpdater.
	
	self assert: element boundsInLocal equals: (0@0 extent: 150@150).
	self assert: element bounds inParent asRectangle equals: (50@50 extent: 150@150).

	"layout recomputation resets position and extent to originally requested values"
	element requestLayout.
	element forceLayout.
	self assert: element boundsInLocal equals: (0@0 extent: 100@100).
	self assert: element bounds inParent asRectangle equals: (0@0 extent: 100@100).

	^ element
]

{ #category : #tests }
BlElementPositionChangeTest >> testPositionChangeLoop [
	<gtExample>
	| element positionChanged positionChangedListener positionInSpaceChanged positionInSpaceChangedListener anUpdater |
	
	element := self element.
	positionChanged := 0.
	positionInSpaceChanged := 0.
	
	anUpdater := BlElementBoundsUpdater new.

	positionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ positionChanged := positionChanged + 1 ].
	positionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ positionInSpaceChanged := positionInSpaceChanged + 1 ].
	
	element addEventHandler: positionChangedListener.
	element addEventHandler: positionInSpaceChangedListener.
	
	element position: 30@30 extent: element extent context: anUpdater.
	anUpdater commitChanges.
	
	self assert: positionChanged equals: 1.
	self assert: positionInSpaceChanged equals: 1.
	
	positionChanged := 0.
	positionInSpaceChanged := 0.
	
	anUpdater := BlElementBoundsUpdater new.
	element position: 40@40 extent: element extent context: anUpdater.
	element position: 30@30 extent: element extent context: anUpdater..
	anUpdater commitChanges.
	
	self assert: positionChanged equals: 0.
	self assert: positionInSpaceChanged equals: 0.

	^ element
]
