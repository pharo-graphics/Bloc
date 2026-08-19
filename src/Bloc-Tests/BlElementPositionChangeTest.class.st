"
I contain examples of position change logging functionality
"
Class {
	#name : #BlElementPositionChangeTest,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Tests-Basic-Changes'
}

{ #category : #accessing }
BlElementPositionChangeTest >> newElementTree [

	| parent child subChild |
	parent := BlElement new.
	parent extent: 200 @ 200.
	parent background: Color blue.

	child := BlElement new.
	child extent: 150 @ 150.
	child background: Color red.

	subChild := BlElement new.
	subChild extent: 100 @ 100.
	subChild background: Color green.

	child addChild: subChild.
	parent addChild: child.

	^ parent
]

{ #category : #running }
BlElementPositionChangeTest >> setUp [
	super setUp.
	space := BlSpace new.
	space host: BlHeadlessHost new.
	space show; settle
]

{ #category : #running }
BlElementPositionChangeTest >> tearDown [
	space ifNotNil: [
		space close; settle.
		space := nil ].
	super tearDown
]

{ #category : #tests }
BlElementPositionChangeTest >> testParentPositionChanged [
	| parent parentPositionChangedListener parentPositionInSpaceChangedListener parentPositionChanged parentPositionInSpaceChanged child childPositionChangedListener childPositionInSpaceChangedListener childPositionChanged childPositionInSpaceChanged subChild subChildPositionChangedListener subChildPositionInSpaceChangedListener subChildPositionChanged subChildPositionInSpaceChanged anUpdater |
	parentPositionChanged := parentPositionInSpaceChanged := 0.
	childPositionChanged := childPositionInSpaceChanged := 0.
	subChildPositionChanged := subChildPositionInSpaceChanged := 0.

	parent := self newElementTree.
	space deferAndSettle: [ space root addChild: parent ].

	child := parent children first.
	subChild := child children first.

	parentPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [
		parentPositionChanged := parentPositionChanged + 1 ].
	parentPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [
		parentPositionInSpaceChanged := parentPositionInSpaceChanged + 1 ].

	childPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [
		childPositionChanged := childPositionChanged + 1 ].
	childPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [
		childPositionInSpaceChanged := childPositionInSpaceChanged + 1 ].

	subChildPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [
		subChildPositionChanged := subChildPositionChanged + 1 ].
	subChildPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [
		subChildPositionInSpaceChanged := subChildPositionInSpaceChanged + 1 ].

	parent addEventHandler: parentPositionChangedListener.
	parent addEventHandler: parentPositionInSpaceChangedListener.
	child addEventHandler: childPositionChangedListener.
	child addEventHandler: childPositionInSpaceChangedListener.
	subChild addEventHandler: subChildPositionChangedListener.
	subChild addEventHandler: subChildPositionInSpaceChangedListener.

	anUpdater := BlElementBoundsUpdater new.
	parent position: 20 @ 20 extent: parent extent context: anUpdater.
	child position: 20 @ 20 extent: child extent context: anUpdater.
	subChild position: 20 @ 20 extent: subChild extent context: anUpdater.
	anUpdater commitChanges.

	self assert: parentPositionChanged equals: 1.
	self assert: parentPositionInSpaceChanged equals: 1.
	self assert: childPositionChanged equals: 1.
	self assert: childPositionInSpaceChanged equals: 1.
	self assert: subChildPositionChanged equals: 1.
	self assert: subChildPositionInSpaceChanged equals: 1.

	^ parent
]

{ #category : #tests }
BlElementPositionChangeTest >> testPositionChangeBoundsChange [
	| element anUpdater |
	element := BlElement new.
	element background: Color blue.
	element extent: 100 @ 100.
	element position: 0 @ 0.
	space deferAndSettle: [ space root addChild: element ].

	anUpdater := BlElementBoundsUpdater new.

	self assert: element boundsInLocal equals: (0 @ 0 extent: 100 @ 100).
	self assert: element bounds inParent asRectangle equals: (0 @ 0 extent: 100 @ 100).

	element position: 30 @ 30 extent: element extent context: anUpdater.

	self assert: element boundsInLocal equals: (0 @ 0 extent: 100 @ 100).
	self assert: element bounds inParent asRectangle equals: (30 @ 30 extent: 100 @ 100).

	element position: 50 @ 50 extent: 150 @ 150 context: anUpdater.

	self assert: element boundsInLocal equals: (0 @ 0 extent: 150 @ 150).
	self assert: element bounds inParent asRectangle equals: (50 @ 50 extent: 150 @ 150).

	space deferAndSettle: [ element requestLayout ].
	self assert: element boundsInLocal equals: (0 @ 0 extent: 100 @ 100).
	self assert: element bounds inParent asRectangle equals: (0 @ 0 extent: 100 @ 100).

	^ element
]

{ #category : #tests }
BlElementPositionChangeTest >> testPositionChangeLoop [

	| element positionChanged positionChangedListener positionInSpaceChanged positionInSpaceChangedListener anUpdater |
	element := BlElement new.
	positionChanged := 0.
	positionInSpaceChanged := 0.

	anUpdater := BlElementBoundsUpdater new.

	positionChangedListener := BlEventHandler
		                           on: BlElementPositionChangedEvent
		                           do: [
		                           positionChanged := positionChanged + 1 ].
	positionInSpaceChangedListener := BlEventHandler
		                                  on:
		                                  BlElementPositionInSpaceChangedEvent
		                                  do: [
		                                  positionInSpaceChanged := positionInSpaceChanged
		                                                            + 1 ].

	element addEventHandler: positionChangedListener.
	element addEventHandler: positionInSpaceChangedListener.

	element position: 30 @ 30 extent: element extent context: anUpdater.
	anUpdater commitChanges.

	self assert: positionChanged equals: 1.
	self assert: positionInSpaceChanged equals: 1.

	positionChanged := 0.
	positionInSpaceChanged := 0.

	anUpdater := BlElementBoundsUpdater new.
	element position: 40 @ 40 extent: element extent context: anUpdater.
	element position: 30 @ 30 extent: element extent context: anUpdater.
	anUpdater commitChanges.

	self assert: positionChanged equals: 0.
	self assert: positionInSpaceChanged equals: 0.

	^ element
]
