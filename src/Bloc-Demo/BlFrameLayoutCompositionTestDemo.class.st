Class {
	#name : #BlFrameLayoutCompositionTestDemo,
	#superclass : #BlRootLayoutTest,
	#category : #'Bloc-Demo-FromTests'
}

{ #category : #helpers }
BlFrameLayoutCompositionTestDemo >> container [

	<sampleInstance>
	^ self element
		  padding: (BlInsets all: 10);
		  background: Color blue
]

{ #category : #helpers }
BlFrameLayoutCompositionTestDemo >> element [

	<sampleInstance>
	^ BlElement new
]

{ #category : #helpers }
BlFrameLayoutCompositionTestDemo >> green [

	<sampleInstance>
	^ self element
		  background: Color green;
		  border: (BlBorder paint: Color black width: 4)
]

{ #category : #helpers }
BlFrameLayoutCompositionTestDemo >> originClassName [
	"This test was generated from..."

	^ 'BlFrameLayoutCompositionExamples'
]

{ #category : #helpers }
BlFrameLayoutCompositionTestDemo >> red [

	<sampleInstance>
	^ self element
		  background: Color red;
		  border: (BlBorder paint: Color lightGray width: 4)
]

{ #category : #'tests - demo' }
BlFrameLayoutCompositionTestDemo >> testExample [

	<sampleInstance>
	| yellow green red container |
	yellow := self yellow constraintsDo: [ :c |
		          c horizontal matchParent.
		          c vertical matchParent ].
	green := self green
		         size: 200 @ 200;
		         constraintsDo: [ :c |
			         c frame horizontal alignRight.
			         c frame vertical alignBottom ].
	red := self red
		       size: 100 @ 100;
		       constraintsDo: [ :c |
			       c frame horizontal alignCenter.
			       c frame vertical alignCenter ].
	container := self container
		             layout: BlFrameLayout new;
		             size: 350 @ 350;
		             addChildren: {
				             yellow.
				             green.
				             red }.
	^ container
]

{ #category : #'tests - demo' }
BlFrameLayoutCompositionTestDemo >> testExampleReverseOrder [

	<sampleInstance>
	| yellow green red container |
	yellow := self yellow constraintsDo: [ :c |
		          c horizontal matchParent.
		          c vertical matchParent ].
	green := self green
		         size: 200 @ 200;
		         constraintsDo: [ :c |
			         c frame horizontal alignRight.
			         c frame vertical alignBottom ].
	red := self red
		       size: 100 @ 100;
		       constraintsDo: [ :c |
			       c frame horizontal alignCenter.
			       c frame vertical alignCenter ].
	container := self container
		             layout: BlFrameLayout new;
		             size: 350 @ 350;
		             addChildren: {
				             red.
				             green.
				             yellow }.
	^ container
]

{ #category : #helpers }
BlFrameLayoutCompositionTestDemo >> yellow [

	<sampleInstance>
	^ self element
		  background: Color yellow;
		  border: (BlBorder paint: Color darkGray width: 4)
]
