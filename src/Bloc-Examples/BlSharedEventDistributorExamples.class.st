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
		addEventHandlerOn: BlMouseDownEvent do: [ :anEvent | anElement background: Color random ];
		addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | anElement background: aHighlightColor ];
		addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | anElement background: aBackgroundColor ].
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
BlSharedEventDistributorExamples >> mouseDownEventOneOutOfTwoElements [
	<gtExample>
	| aHandler anElements aContainer aMouseEnterTwo aMouseEnterOne anElementOne anElementTwo aPosition anEvent |
	aMouseEnterOne := aMouseEnterTwo := 0.
	aHandler := self installTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: { BlMouseDownEvent }.
	anElementOne addEventHandlerOn: BlMouseDownEvent do: [ aMouseEnterOne := aMouseEnterOne + 1 ].
	anElementTwo addEventHandlerOn: BlMouseDownEvent do: [ aMouseEnterTwo := aMouseEnterTwo + 1 ].
	
	aContainer topMostParent forceLayout.
	aPosition := anElementOne bounds inSpace center.
	anEvent := BlMouseEnterEvent new position: aPosition.
	BlSpace simulateEvent: anEvent on: anElementOne.

	"self assert: aMouseEnterOne equals: 1.
	self assert: aMouseEnterTwo equals: 2."
	
	^ aContainer
]

{ #category : #'examples - sharing events' }
BlSharedEventDistributorExamples >> mouseEnterEventOneOutOfTwoElements [
	<gtExample>
	| aHandler anElements aContainer aMouseEnterTwo aMouseEnterOne anElementOne anElementTwo aPosition anEvent |
	aMouseEnterOne := aMouseEnterTwo := 0.
	aHandler := self installTwoElements.
	anElements := aHandler elements.
	aContainer := self container.
	aContainer addChildren: anElements.
	anElementOne := anElements first.
	anElementTwo := anElements second.

	aHandler shareEvents: { BlMouseEnterEvent. BlMouseEnterEvent }.
	anElementOne addEventHandlerOn: BlMouseEnterEvent do: [ aMouseEnterOne := aMouseEnterOne + 1 ].
	anElementTwo addEventHandlerOn: BlMouseEnterEvent do: [ aMouseEnterTwo := aMouseEnterTwo + 1 ].
	
	aContainer topMostParent forceLayout.
	aPosition := anElementOne bounds inSpace center.
	anEvent := BlMouseEnterEvent new position: aPosition.
	BlSpace simulateEvent: anEvent on: anElementOne.

	"self assert: aMouseEnterOne equals: 1.
	self assert: aMouseEnterTwo equals: 2."
	
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
