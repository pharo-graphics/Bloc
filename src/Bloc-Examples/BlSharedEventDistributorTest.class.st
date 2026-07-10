"
I exemplify `BlSharedEventDistributor`.

"
Class {
	#name : #BlSharedEventDistributorTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-EventHandling'
}

{ #category : #'examples - sharing events' }
BlSharedEventDistributorTest >> example [
	<sampleInstance>

	| aHandler elements aContainer |
	aHandler := BlSharedEventDistributor new.
	self newSquaredElement addEventHandler: aHandler.
	self newSquaredElement addEventHandler: aHandler.
	elements := aHandler elements.
	aContainer := self newContainer.
	aContainer addChildren: elements.
	aHandler shareEvents: {
			BlMouseEnterEvent.
			BlMouseLeaveEvent.
			BlClickEvent }.
	^ aContainer
]

{ #category : #'instance creation' }
BlSharedEventDistributorTest >> newContainer [

	^ BlElement new
		layout: BlLinearLayout horizontal;
		background: Color veryLightGray lighter;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c margin: (BlInsets all: 3).
			c padding: (BlInsets all: 3) ];
		yourself
]

{ #category : #'instance creation' }
BlSharedEventDistributorTest >> newSquaredElement [

	| aBackgroundColor aHighlightColor anElement |
	aBackgroundColor := {
		Color green.
		Color yellow.
		Color red } atRandom.
	aHighlightColor := aBackgroundColor darker.

	anElement := BlElement new.
	anElement
		extent: 100 @ 100;
		background: aBackgroundColor;
		margin: (BlInsets all: 3);
		addEventHandlerOn: BlClickEvent
			do: [ :anEvent | anElement background: Color random ];
		addEventHandlerOn: BlMouseEnterEvent
			do: [ :anEvent | anElement background: aHighlightColor ];
		addEventHandlerOn: BlMouseLeaveEvent
			do: [ :anEvent | anElement background: aBackgroundColor ].

	^ anElement
]

{ #category : #'examples - basic' }
BlSharedEventDistributorTest >> testInstallOneElement [

	| aHandler anElement |
	aHandler := BlSharedEventDistributor new.
	anElement := self newSquaredElement.
	anElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 1
]

{ #category : #'examples - basic' }
BlSharedEventDistributorTest >> testInstallTwoElements [

	| aHandler |
	aHandler := BlSharedEventDistributor new.
	self newSquaredElement addEventHandler: aHandler.
	self newSquaredElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 2
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorTest >> testMouseEnterEventOneOutOfTwoElements [

	| aHandler anElements aContainer aMouseEnterTwo aMouseEnterOne anElementOne anElementTwo aSpace |
	aMouseEnterOne := aMouseEnterTwo := 0.
	aHandler := BlSharedEventDistributor new.
	self newSquaredElement addEventHandler: aHandler.
	self newSquaredElement addEventHandler: aHandler.

	anElements := aHandler elements.
	aContainer := self newContainer.
	aContainer addChildren: anElements.
	aSpace := BlSpace new.
	aSpace root addChild: aContainer.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: {
			BlMouseEnterEvent.
			BlMouseLeaveEvent.
			BlClickEvent }.
	anElementOne addEventHandler:
		(BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ aMouseEnterOne := aMouseEnterOne + 1 ]).
	anElementTwo addEventHandler:
		(BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ aMouseEnterTwo := aMouseEnterTwo + 1 ]).

	anElementOne simulator mouseMoveInside.

	self assert: aMouseEnterOne equals: 1.
	self assert: aMouseEnterTwo equals: 1
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorTest >> testMouseLeaveEventOneOutOfTwoElements [

	| aHandler anElements aContainer aMouseLeaveTwo aMouseLeaveOne anElementOne anElementTwo aSpace |
	aMouseLeaveOne := aMouseLeaveTwo := 0.
	aHandler := BlSharedEventDistributor new.
	self newSquaredElement addEventHandler: aHandler.
	self newSquaredElement addEventHandler: aHandler.

	anElements := aHandler elements.
	aContainer := self newContainer.
	aContainer addChildren: anElements.
	aSpace := BlSpace new.
	aSpace root addChild: aContainer.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: {
			BlMouseEnterEvent.
			BlMouseLeaveEvent.
			BlClickEvent }.
	anElementOne addEventHandler:
		(BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ aMouseLeaveOne := aMouseLeaveOne + 1 ]).
	anElementTwo addEventHandler:
		(BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ aMouseLeaveTwo := aMouseLeaveTwo + 1 ]).

	aContainer simulator
		events: {
				(BlMouseMoveEvent new
					 position: (anElementOne simulator locationInside);
					 screenPosition: 0 @ 0;
					 yourself).
				(BlMouseMoveEvent new
					 position: (aContainer simulator locationOutside);
					 screenPosition: 0 @ 0;
					 yourself) }.

	self assert: aMouseLeaveOne equals: 1.
	self assert: aMouseLeaveTwo equals: 1
]

{ #category : #'examples - basic' }
BlSharedEventDistributorTest >> testUninstallOneElement [

	| aHandler anElement |
	aHandler := BlSharedEventDistributor new.
	anElement := self newSquaredElement.
	anElement addEventHandler: aHandler.
	anElement removeEventHandler: aHandler.
	self assert: aHandler elements size equals: 0
]
