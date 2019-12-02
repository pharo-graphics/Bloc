"
I exemplify ${class:BlSharedEventDistributor}$.
"
Class {
	#name : #BlSharedEventDistributorExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-EventHandling'
}

{ #category : #'instance creation' }
BlSharedEventDistributorExamples >> container [
	<gtExample>
	^ self element
		layout: BlLinearLayout horizontal;
		background: Color veryLightGray lighter;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c margin: (BlInsets all: 3).
			c padding: (BlInsets all: 3).
		]
]

{ #category : #'instance creation' }
BlSharedEventDistributorExamples >> element [
	<gtExample>
	^ BlElement new
]

{ #category : #'instance creation' }
BlSharedEventDistributorExamples >> element100x100 [
	<gtExample>
	| aBackgroundColor aHighlightColor anElement |
	aBackgroundColor := self randomColor.
	aHighlightColor := aBackgroundColor darker.
	anElement := self element.
	^ anElement
		size: 100@100;
		background: aBackgroundColor;
		margin: (BlInsets all: 3);
		addEventHandlerOn: BlClickEvent do: [ :anEvent | anElement background: Color random ];
		addEventHandlerOn: BlMouseOverEvent do: [ :anEvent | anElement background: aHighlightColor ];
		addEventHandlerOn: BlMouseOutEvent do: [ :anEvent | anElement background: aBackgroundColor ].
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorExamples >> example [
	<gtExample>
	| aHandler anElements aContainer |
	aHandler := self installTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	aHandler shareEvents: { BlMouseOverEvent. BlMouseOutEvent. BlClickEvent }.
	^ aContainer
]

{ #category : #'examples - basic' }
BlSharedEventDistributorExamples >> installOneElement [
	<gtExample>
	| aHandler anElement |
	aHandler := self sharedEventDistributor.
	anElement := self element100x100.
	anElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 1.
	^ aHandler
]

{ #category : #'examples - basic' }
BlSharedEventDistributorExamples >> installTwoElements [
	<gtExample>
	| aHandler anElement |
	aHandler := self installOneElement.
	anElement := self element100x100.
	anElement addEventHandler: aHandler.
	self assert: aHandler elements size equals: 2.
	^ aHandler
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorExamples >> mouseOutEventOneOutOfTwoElements [
	<gtExample>
	| aHandler anElements aContainer aMouseEnterTwo aMouseEnterOne anElementOne anElementTwo anEvent |
	aMouseEnterOne := aMouseEnterTwo := 0.
	aHandler := self installTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: { BlMouseOverEvent. BlMouseOutEvent. BlClickEvent }.
	anElementOne addEventHandlerOn: BlMouseOutEvent do: [ aMouseEnterOne := aMouseEnterOne + 1 ].
	anElementTwo addEventHandlerOn: BlMouseOutEvent do: [ aMouseEnterTwo := aMouseEnterTwo + 1 ].
	
	anEvent := BlMouseOutEvent new.
	BlSpace simulateEvent: anEvent on: anElementOne.

	"self assert: aMouseEnterOne equals: 1.
	self assert: aMouseEnterTwo equals: 1."
	
	^ aContainer
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorExamples >> mouseOverEventOneOutOfTwoElements [
	<gtExample>
	| aHandler anElements aContainer aMouseEnterTwo aMouseEnterOne anElementOne anElementTwo anEvent |
	aMouseEnterOne := aMouseEnterTwo := 0.
	aHandler := self installTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: { BlMouseOverEvent. BlMouseOutEvent. BlClickEvent }.
	anElementOne addEventHandlerOn: BlMouseOverEvent do: [ aMouseEnterOne := aMouseEnterOne + 1 ].
	anElementTwo addEventHandlerOn: BlMouseOverEvent do: [ aMouseEnterTwo := aMouseEnterTwo + 1 ].
	
	anEvent := BlMouseOverEvent new.
	BlSpace simulateEvent: anEvent on: anElementOne.

	"self assert: aMouseEnterOne equals: 1.
	self assert: aMouseEnterTwo equals: 1."
	
	^ aContainer
]

{ #category : #'instance creation' }
BlSharedEventDistributorExamples >> randomColor [
	<gtExample>
	^ { Color green. Color yellow. Color red } atRandom
]

{ #category : #'instance creation' }
BlSharedEventDistributorExamples >> sharedEventDistributor [
	<gtExample>
	| aHandler |
	aHandler := BlSharedEventDistributor new.
	self assert: aHandler elements isEmpty.
	^ aHandler
]

{ #category : #'examples - basic' }
BlSharedEventDistributorExamples >> uninstallOneElement [
	<gtExample>
	| aHandler anElement |
	aHandler := self installOneElement.
	anElement := aHandler elements anyOne.
	anElement removeEventHandler: aHandler.
	self assert: aHandler elements size equals: 0.
	^ aHandler
]
