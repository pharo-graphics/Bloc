"
I exemplify `BlDevHalosEventListener`.

"
Class {
	#name : #BlDevHalosEventListenerExample,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-DevTool-Examples'
}

{ #category : #private }
BlDevHalosEventListenerExample >> newContainerListeningForHalos [
	<sampleInstance>
	<demo>

	| anElement |
	anElement := BlElement new.
	anElement
		layout: BlFrameLayout new;
		extent: 300 @ 300;
		background: Color white;
		border: (BlBorder paint: Color blue width: 2).

	anElement addChild:
		(BlElement new
			extent: 100 @ 100;
			background: Color gray;
			border: (BlBorder paint: Color black width: 2);
			constraintsDo: [ :c |
				c frame vertical alignCenter.
				c frame horizontal alignCenter ];
			yourself).

	anElement addEventFilter: BlDevHalosEventListener new.
	anElement addChild:
		(BlTextElement new
			text: 'shift+alt+click on the element to show halo' asRopedText;
			padding: (BlInsets all: 10);
			yourself).

	^ anElement
]
