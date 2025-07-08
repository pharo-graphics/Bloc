"
I exemplify `BlMetricsInspector`.

"
Class {
	#name : #BlMetricsInspectorExample,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-DevTool-Examples'
}

{ #category : #examples }
BlMetricsInspectorExample >> metricsInspectorOnElementWithMetrics [
	<sampleInstance>
	<demo>

	| anInspector anElement |
	anElement := self newElementWithMarginAndPadding.

	anInspector := BlMetricsInspector new.
	anInspector for: anElement.

	self assert: anInspector childrenCount equals: 1.
	self
		assert: ((anInspector childAt: 1) childAt: 2) text asString
		equals: '1.0'.
	self
		assert: ((anInspector childAt: 1) childAt: 3) text asString
		equals: '2.0'.
	self
		assert: ((anInspector childAt: 1) childAt: 4) text asString
		equals: '3.0'.
	self
		assert: ((anInspector childAt: 1) childAt: 5) text asString
		equals: '4.0'.
	^ anInspector
]

{ #category : #examples }
BlMetricsInspectorExample >> metricsInspectorOnUninitializedElement [
	<sampleInstance>
	<demo>

	| anInspector anElement |
	anElement := BlElement new.

	anInspector := BlMetricsInspector new.
	anInspector for: anElement.

	self assert: anInspector childrenCount equals: 1.
	self
		assert: ((anInspector childAt: 1) childAt: 1) text asString
		equals: 'margin'.
	self
		assert: ((anInspector childAt: 1) childAt: 2) text asString
		equals: '-'.
	^ anInspector
]

{ #category : #examples }
BlMetricsInspectorExample >> newElementWithMarginAndPadding [

	^ BlElement new
		  margin: (BlInsets
				   top: 1
				   right: 2
				   bottom: 3
				   left: 4);
		  padding: (BlInsets
				   top: 5
				   right: 6
				   bottom: 7
				   left: 8);
		  extent: 300 @ 100;
		  background: Color lightGray;
		  border: (BlBorder paint: Color black width: 2);
		  yourself
]
