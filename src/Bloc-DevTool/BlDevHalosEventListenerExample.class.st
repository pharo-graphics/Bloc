"
I exemplify `BlDevHalosEventListener`.

"
Class {
	#name : #BlDevHalosEventListenerExample,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-DevTool-Examples'
}

{ #category : #examples }
BlDevHalosEventListenerExample >> activatedHalos [
	<sampleInstance>
	<demo>

	| aContainer aSpace aPosition anEvent |
	aContainer := self newContainerWithRectangle.
	aSpace := BlSpace new.
	aSpace root addChild: aContainer.
	aSpace addHalosListener.
	BlSpace pulseUntilEmptyTaskQueue: aSpace timeout: 500 milliSeconds.

	self assert: aSpace root children size equals: 1.

	"shift+alt+click on the element shows the halo"
	aPosition := aContainer bounds inSpace center.
	anEvent := BlMouseDownEvent primary
		position: aPosition;
		yourself.
	anEvent modifiers
		alt: true;
		shift: true.
	BlSpace simulateEvent: anEvent on: (aContainer childAt: 1).

	self assert: aSpace root children size equals: 2.

	^ aSpace
]

{ #category : #private }
BlDevHalosEventListenerExample >> newContainerWithRectangle [

	| anElement |
	anElement := BlElement new.
	anElement
		layout: BlFrameLayout new;
		size: 300 @ 300;
		background: Color white;
		border: (BlBorder paint: Color blue width: 2).

	anElement addChild: self newRectangle.

	^ anElement
]

{ #category : #private }
BlDevHalosEventListenerExample >> newRectangle [

	^ BlElement new
		size: 100 @ 100;
		background: Color gray;
		border: (BlBorder paint: Color black width: 2);
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ];
		yourself
]

{ #category : #private }
BlDevHalosEventListenerExample >> newSpace [

	| aSpace |
	aSpace := BlSpace new.
"	aSpace host: BlHeadlessHost new."
	aSpace extent: 600 @ 400.
	aSpace withHalos.
	^ aSpace
]
