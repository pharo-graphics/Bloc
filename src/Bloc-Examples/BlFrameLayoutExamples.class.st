"
I contain examples of a frame layout.

I show how different alignments  work
"
Class {
	#name : #BlFrameLayoutExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Layout'
}

{ #category : #'instance creation' }
BlFrameLayoutExamples >> container [
	<gtExample>
	
	^ self element
		padding: (BlInsets all: 10);
		background: Color blue
]

{ #category : #'instance creation' }
BlFrameLayoutExamples >> element [
	<gtExample>
	
	^ BlElement new
]

{ #category : #example }
BlFrameLayoutExamples >> example [
	<gtExample>
	| yellow green red container |
	
	yellow := self yellow
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	green := self green
		size: 200@200;
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignBottom ].
	
	red := self red
		size: 100@100;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].

	container := self container
		layout: BlFrameLayout new;
		size: 350@350;
		relocate: 200@100;
		addChildren: { yellow . green . red }.
	
	^ container
	
]

{ #category : #'instance creation' }
BlFrameLayoutExamples >> green [
	<gtExample>
	
	^ self element
		background: Color green;
		border: (BlBorder paint: Color black width: 4)
]

{ #category : #'instance creation' }
BlFrameLayoutExamples >> red [
	<gtExample>
	
	^ self element
		background: Color red;
		border: (BlBorder paint: Color lightGray width: 4)
]

{ #category : #'instance creation' }
BlFrameLayoutExamples >> yellow [
	<gtExample>
	
	^ self element
		background: Color yellow;
		border: (BlBorder paint: Color darkGray width: 4)
]
