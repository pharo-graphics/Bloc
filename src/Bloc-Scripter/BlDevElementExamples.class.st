Class {
	#name : #BlDevElementExamples,
	#superclass : #BlExampleTest,
	#category : 'Bloc-Scripter-Examples'
}

{ #category : #'examples - element' }
BlDevElementExamples >> container [

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
BlDevElementExamples >> containerWithRectangle [

	<sampleInstance>
	| anElement |
	anElement := self container.
	anElement addChild: self rectangle.
	^ anElement
]

{ #category : #'examples - element' }
BlDevElementExamples >> element [

	<sampleInstance>
	^ BlElement new
]

{ #category : #'examples - element' }
BlDevElementExamples >> rectangle [

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
