"
I exemplify ${class:BlDevHalosEventListener}$.
"
Class {
	#name : #BlDevHalosEventListenerExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-DevTool-Examples'
}

{ #category : #'examples - handler' }
BlDevHalosEventListenerExamples >> activatedHalos [
	<gtExample>
	| aContainer aSpace thePriorElements theNewElements aPosition anEvent |
	aContainer := self containerWithRectangle.
	aSpace := self putInSpace: aContainer.
	aSpace withHalos.
	thePriorElements := aSpace root children asArray.
	
	"we never know if an element was already layered out"
	aContainer topMostParent forceLayout.
	aPosition := aContainer bounds inSpace center.
	anEvent :=  BlMouseDownEvent primary position: aPosition.
	anEvent modifiers alt: true; shift: true.
	BlSpace simulateEvent: anEvent on: (aContainer childAt: 1).
	
	theNewElements := aSpace root children asArray.
	"self assert: theNewElements size equals: thePriorElements size + 1."
	^ aSpace
]

{ #category : #'examples - handler' }
BlDevHalosEventListenerExamples >> basicHalosEventListener [
	<gtExample>
	^ BlDevHalosEventListener new
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExamples >> container [
	<gtExample>
	| anElement |
	anElement := self element.
	anElement
		layout: BlFrameLayout new;
		size: 300@300;
		background: Color white;
		border: (BlBorder paint: Color blue width: 2).
	^ anElement
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExamples >> containerWithRectangle [
	<gtExample>
	| anElement |
	anElement := self container.
	anElement
		addChild: self rectangle.
	^ anElement
]

{ #category : #'examples - handler' }
BlDevHalosEventListenerExamples >> containerWithRectangleWithHalos [
	<gtExample>
	| aHandler aContainer |
	aHandler := self basicHalosEventListener.
	aContainer := self containerWithRectangle.
	aContainer addEventFilter: aHandler.
	^ aContainer
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExamples >> element [
	<gtExample>
	^ BlElement new
]

{ #category : #'instance creation' }
BlDevHalosEventListenerExamples >> newSpace [
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Async Element Examples'.
	aSpace extent: 600@400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #utility }
BlDevHalosEventListenerExamples >> putInSpace: aBlElement [
	<gtExample>
	| aSpace |
	self 
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace root addChild: aBlElement.
	^ aSpace
]

{ #category : #'examples - element' }
BlDevHalosEventListenerExamples >> rectangle [
	<gtExample>
	| anElement |
	anElement := self element.
	anElement
		size: 100@100;
		background: Color gray;
		border: (BlBorder paint: Color black width: 2);
		constraintsDo: [ :c | 
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	^ anElement
]
