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
	aHandler := self testInstallTwoElements.
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
		size: 100 @ 100;
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
	self assert: aHandler elements size equals: 1.
	^ aHandler
]

{ #category : #'examples - basic' }
BlSharedEventDistributorTest >> testInstallTwoElements [

	| aHandler anElement |
	aHandler := self testInstallOneElement.
	anElement := self newSquaredElement.
	anElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 2.
	^ aHandler
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorTest >> testMouseEnterEventOneOutOfTwoElements [

	| aHandler anElements aContainer aMouseEnterTwo aMouseEnterOne anElementOne anElementTwo |
	aMouseEnterOne := aMouseEnterTwo := 0.
	aHandler := self testInstallTwoElements.
	anElements := aHandler elements.
	aContainer := self newContainer.
	aContainer addChildren: anElements.
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

	BlSpace simulateMouseMoveInside: anElementOne.

	self assert: aMouseEnterOne equals: 1.
	self assert: aMouseEnterTwo equals: 1
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorTest >> testMouseLeaveEventOneOutOfTwoElements [

	| aHandler anElements aContainer aMouseLeaveTwo aMouseLeaveOne anElementOne anElementTwo |
	aMouseLeaveOne := aMouseLeaveTwo := 0.
	aHandler := self testInstallTwoElements.
	anElements := aHandler elements.
	aContainer := self newContainer.
	aContainer addChildren: anElements.
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

	BlSpace
		simulateEvents: {
				(BlMouseMoveEvent new
					 position: (BlSpace locationInside: anElementOne);
					 screenPosition: 0 @ 0;
					 yourself).
				(BlMouseMoveEvent new
					 position: (BlSpace locationOutside: aContainer);
					 screenPosition: 0 @ 0;
					 yourself) }
		on: aContainer.

	self assert: aMouseLeaveOne equals: 1.
	self assert: aMouseLeaveTwo equals: 1
]

{ #category : #'examples - basic' }
BlSharedEventDistributorTest >> testUninstallOneElement [

	| aHandler anElement |
	aHandler := self testInstallOneElement.
	anElement := aHandler elements anyOne.
	anElement removeEventHandler: aHandler.
	self assert: aHandler elements size equals: 0.
	^ aHandler
]
