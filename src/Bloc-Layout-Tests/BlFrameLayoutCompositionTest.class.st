"
I have been automatically converted and probably manually tweaked from BlFrameLayoutCompositionExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
	
Pay attention none of the methods contains assertions.
"
Class {
	#name : #BlFrameLayoutCompositionTest,
	#superclass : #BlRootLayoutTest,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #helpers }
BlFrameLayoutCompositionTest >> container [

	<sampleInstance>
	<demo>
	^ self element
		  padding: (BlInsets all: 10);
		  background: Color blue
]

{ #category : #helpers }
BlFrameLayoutCompositionTest >> element [

	<sampleInstance>
	<demo>
	^ BlElement new
]

{ #category : #helpers }
BlFrameLayoutCompositionTest >> green [

	<sampleInstance>
	<demo>
	^ self element
		  background: Color green;
		  border: (BlBorder paint: Color black width: 4)
]

{ #category : #helpers }
BlFrameLayoutCompositionTest >> originClassName [
	"This test was generated from..."

	^ 'BlFrameLayoutCompositionExamples'
]

{ #category : #helpers }
BlFrameLayoutCompositionTest >> red [

	<sampleInstance>
	<demo>
	^ self element
		  background: Color red;
		  border: (BlBorder paint: Color lightGray width: 4)
]

{ #category : #tests }
BlFrameLayoutCompositionTest >> testExample [

	<sampleInstance>
	<demo>
	| yellow green red container |
	yellow := self yellow constraintsDo: [ :c |
		          c horizontal matchParent.
		          c vertical matchParent ].
	green := self green
		         extent: 200 @ 200;
		         constraintsDo: [ :c |
			         c frame horizontal alignRight.
			         c frame vertical alignBottom ].
	red := self red
		       extent: 100 @ 100;
		       constraintsDo: [ :c |
			       c frame horizontal alignCenter.
			       c frame vertical alignCenter ].
	container := self container
		             layout: BlFrameLayout new;
		             extent: 350 @ 350;
		             position: 200 @ 100;
		             addChildren: {
				             yellow.
				             green.
				             red }.
	^ container
]

{ #category : #tests }
BlFrameLayoutCompositionTest >> testExampleReverseOrder [

	<sampleInstance>
	<demo>
	| yellow green red container |
	yellow := self yellow constraintsDo: [ :c |
		          c horizontal matchParent.
		          c vertical matchParent ].
	green := self green
		         extent: 200 @ 200;
		         constraintsDo: [ :c |
			         c frame horizontal alignRight.
			         c frame vertical alignBottom ].
	red := self red
		       extent: 100 @ 100;
		       constraintsDo: [ :c |
			       c frame horizontal alignCenter.
			       c frame vertical alignCenter ].
	container := self container
		             layout: BlFrameLayout new;
		             extent: 350 @ 350;
		             position: 200 @ 100;
		             addChildren: {
				             red.
				             green.
				             yellow }.
	^ container
]

{ #category : #helpers }
BlFrameLayoutCompositionTest >> yellow [

	<sampleInstance>
	<demo>
	^ self element
		  background: Color yellow;
		  border: (BlBorder paint: Color darkGray width: 4)
]
