"
I exemplify `BlSharedEventDistributor`.

"
Class {
	#name : #BlSharedEventDistributorTest,
	#superclass : #BlParameterizedHostTest,
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
BlSharedEventDistributorTest >> testInstallTwoElements [

	| aHandler |
	aHandler := BlSharedEventDistributor new.

	self newSquaredElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 1.

	self newSquaredElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 2
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorTest >> testMouseEnterEventOneOutOfTwoElements [

	| aHandler aContainer countB countA elementA elementB aSpace |
	elementA := self newSquaredElement.
	elementB := self newSquaredElement.

	aHandler := BlSharedEventDistributor new.
	elementA addEventHandler: aHandler.
	elementB addEventHandler: aHandler.
	aHandler shareEvents: {
		BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BlClickEvent }.

	countA := countB := 0.
	elementA addEventHandler:
		(BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ countA := countA + 1 ]).
	elementB addEventHandler:
		(BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ countB := countB + 1 ]).

	aSpace := self newTestingSpace.
	aContainer := self newContainer.
	aContainer addChildren: aHandler elements.
	aSpace root addChild: aContainer.
	elementA eventSimulator
		mouseMoveInside;
		waitPendingWork.

	self assert: countA equals: 1.
	self assert: countB equals: 1
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorTest >> testMouseLeaveEventOneOutOfTwoElements [

	| aHandler aContainer countB countA elementA elementB aSpace |
	elementA := self newSquaredElement.
	elementB := self newSquaredElement.

	aHandler := BlSharedEventDistributor new.
	elementA addEventHandler: aHandler.
	elementB addEventHandler: aHandler.
	aHandler shareEvents: {
		BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BlClickEvent }.

	countA := countB := 0.
	elementA addEventHandler:
		(BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ countA := countA + 1 ]).
	elementB addEventHandler:
		(BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ countB := countB + 1 ]).

	aSpace := self newTestingSpace.
	aContainer := self newContainer.
	aContainer addChildren: aHandler elements.
	aSpace root addChild: aContainer.
	elementA eventSimulator
		mouseMoveInside;
		mouseMoveOutside.
	self waitTestingSpaces.

	self assert: countA equals: 1.
	self assert: countB equals: 1
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
