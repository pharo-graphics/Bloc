"
I exemplify {{gtClass:BlSharedEventDistributor}}.

"
Class {
	#name : 'BlSharedEventDistributorExamples',
	#superclass : 'BlExampleTest',
	#category : 'Bloc-Examples-EventHandling',
	#package : 'Bloc-Examples',
	#tag : 'EventHandling'
}

{ #category : 'instance creation' }
BlSharedEventDistributorExamples >> container [

	<sampleInstance>
	^ self element
		  layout: BlLinearLayout horizontal;
		  background: Color veryLightGray lighter;
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent.
			  c margin: (BlInsets all: 3).
			  c padding: (BlInsets all: 3) ]
]

{ #category : 'instance creation' }
BlSharedEventDistributorExamples >> element [

	<sampleInstance>
	^ BlElement new
]

{ #category : 'instance creation' }
BlSharedEventDistributorExamples >> element100x100 [

	<sampleInstance>
	| aBackgroundColor aHighlightColor anElement |
	aBackgroundColor := self randomColor.
	aHighlightColor := aBackgroundColor darker.
	anElement := self element.
	^ anElement
		  size: 100 @ 100;
		  background: aBackgroundColor;
		  margin: (BlInsets all: 3);
		  addEventHandlerOn: BlClickEvent
		  do: [ :anEvent | anElement background: Color random ];
		  addEventHandlerOn: BlMouseEnterEvent
		  do: [ :anEvent | anElement background: aHighlightColor ];
		  addEventHandlerOn: BlMouseLeaveEvent
		  do: [ :anEvent | anElement background: aBackgroundColor ]
]

{ #category : 'examples - sharing events' }
BlSharedEventDistributorExamples >> example [

	<sampleInstance>
	| aHandler anElements aContainer |
	aHandler := self testInstallTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	aHandler shareEvents: {
			BlMouseEnterEvent.
			BlMouseLeaveEvent.
			BlClickEvent }.
	^ aContainer
]

{ #category : 'instance creation' }
BlSharedEventDistributorExamples >> randomColor [

	<sampleInstance>
	^ {
		  Color green.
		  Color yellow.
		  Color red } atRandom
]

{ #category : 'examples - basic' }
BlSharedEventDistributorExamples >> testInstallOneElement [

	<sampleInstance>
	| aHandler anElement |
	aHandler := self testSharedEventDistributor.
	anElement := self element100x100.
	anElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 1.
	^ aHandler
]

{ #category : 'examples - basic' }
BlSharedEventDistributorExamples >> testInstallTwoElements [

	<sampleInstance>
	| aHandler anElement |
	aHandler := self testInstallOneElement.
	anElement := self element100x100.
	anElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 2.
	^ aHandler
]

{ #category : 'examples - sharing events' }
BlSharedEventDistributorExamples >> testMouseEnterEventOneOutOfTwoElements [

	<sampleInstance>
	| aHandler anElements aContainer aMouseEnterTwo aMouseEnterOne anElementOne anElementTwo |
	aMouseEnterOne := aMouseEnterTwo := 0.
	aHandler := self testInstallTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: {
			BlMouseEnterEvent.
			BlMouseLeaveEvent.
			BlClickEvent }.
	anElementOne addEventHandler: (BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ aMouseEnterOne := aMouseEnterOne + 1 ]).
	anElementTwo addEventHandler: (BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ aMouseEnterTwo := aMouseEnterTwo + 1 ]).

	BlSpace simulateMouseMoveInside: anElementOne.

	self assert: aMouseEnterOne equals: 1.
	self assert: aMouseEnterTwo equals: 1.

	^ aContainer
]

{ #category : 'examples - sharing events' }
BlSharedEventDistributorExamples >> testMouseLeaveEventOneOutOfTwoElements [

	<sampleInstance>
	| aHandler anElements aContainer aMouseLeaveTwo aMouseLeaveOne anElementOne anElementTwo |
	aMouseLeaveOne := aMouseLeaveTwo := 0.
	aHandler := self testInstallTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: {
			BlMouseEnterEvent.
			BlMouseLeaveEvent.
			BlClickEvent }.
	anElementOne addEventHandler: (BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ aMouseLeaveOne := aMouseLeaveOne + 1 ]).
	anElementTwo addEventHandler: (BlEventHandler
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
	self assert: aMouseLeaveTwo equals: 1.

	^ aContainer
]

{ #category : 'instance creation' }
BlSharedEventDistributorExamples >> testSharedEventDistributor [

	<sampleInstance>
	| aHandler |
	aHandler := BlSharedEventDistributor new.
	self assert: aHandler elements isEmpty.
	^ aHandler
]

{ #category : 'examples - basic' }
BlSharedEventDistributorExamples >> testUninstallOneElement [

	<sampleInstance>
	| aHandler anElement |
	aHandler := self testInstallOneElement.
	anElement := aHandler elements anyOne.
	anElement removeEventHandler: aHandler.
	self assert: aHandler elements size equals: 0.
	^ aHandler
]
