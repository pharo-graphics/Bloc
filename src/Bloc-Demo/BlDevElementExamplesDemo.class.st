Class {
	#name : #BlDevElementExamplesDemo,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'examples - element - demo' }
BlDevElementExamplesDemo >> container [
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

{ #category : #'examples - element - demo' }
BlDevElementExamplesDemo >> containerWithRectangle [
	<gtExample>
	| anElement |
	anElement := self container.
	anElement
		addChild: self rectangle.
	^ anElement
]

{ #category : #'examples - element' }
BlDevElementExamplesDemo >> element [
	<gtExample>
	^ BlElement new
]

{ #category : #'examples - element - demo' }
BlDevElementExamplesDemo >> rectangle [
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
