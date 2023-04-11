"
I exemplify {{gtClass:BlDevHalosEventListener}}.

"
Class {
	#name : #BlDevHalosEventListenerExample,
	#superclass : #BlExampleTest,
	#category : #'Bloc-DevTool-Examples'
}

{ #category : #'examples - handler' }
BlDevHalosEventListenerExample >> activatedHalos [

	<sampleInstance>
	| aContainer aSpace thePriorElements theNewElements aPosition anEvent |
	aContainer := self containerWithRectangle.
	aSpace := self putInSpace: aContainer.
	aSpace withHalos.
	thePriorElements := aSpace children asArray.

	"we never know if an element was already layered out"
	aContainer topMostParent forceLayout.
	aPosition := aContainer bounds inSpace center.
	anEvent := BlMouseDownEvent primary position: aPosition.
	anEvent modifiers
		alt: true;
		shift: true.
	BlSpace simulateEvent: anEvent on: (aContainer childAt: 1).

	theNewElements := aSpace children asArray.
	"self assert: theNewElements size equals: thePriorElements size + 1."
	^ aSpace
]

{ #category : #'examples - handler' }
BlDevHalosEventListenerExample >> basicHalosEventListener [

	<sampleInstance>
	^ BlDevHalosEventListener new
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExample >> container [

	<sampleInstance>
	| anElement |
	anElement := self element.
	anElement
		layout: BlFrameLayout new;
		size: 300 @ 300;
		background: Color white;
		border: (BlBorder paint: Color blue width: 2).
	^ anElement
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExample >> containerWithRectangle [

	<sampleInstance>
	| anElement |
	anElement := self container.
	anElement addChild: self rectangle.
	^ anElement
]

{ #category : #'examples - handler' }
BlDevHalosEventListenerExample >> containerWithRectangleWithHalos [

	<sampleInstance>
	| aHandler aContainer |
	aHandler := self basicHalosEventListener.
	aContainer := self containerWithRectangle.
	aContainer addEventFilter: aHandler.
	^ aContainer
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExample >> element [

	<sampleInstance>
	^ BlElement new
]

{ #category : #'instance creation' }
BlDevHalosEventListenerExample >> newSpace [

	<sampleInstance>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Async Element Examples'.
	aSpace extent: 600 @ 400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #utility }
BlDevHalosEventListenerExample >> putInSpace: aBlElement [

	<sampleInstance>
	| aSpace |
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace addChild: aBlElement.
	^ aSpace
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExample >> rectangle [

	<sampleInstance>
	| anElement |
	anElement := self element.
	anElement
		size: 100 @ 100;
		background: Color gray;
		border: (BlBorder paint: Color black width: 2);
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	^ anElement
]
