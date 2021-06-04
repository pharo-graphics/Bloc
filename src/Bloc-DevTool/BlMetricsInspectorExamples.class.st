"
I exemplify {{gtClass:BlMetricsInspector}}.

"
Class {
	#name : #BlMetricsInspectorExamples,
	#superclass : #BlElement,
	#category : #'Bloc-DevTool-Examples'
}

{ #category : #'examples - inspector' }
BlMetricsInspectorExamples >> basicMetricsInspector [
	<gtExample>
	| anInspector |
	anInspector := BlMetricsInspector new.
	self assert: anInspector childrenCount equals: 1.
	^ anInspector
]

{ #category : #'examples - inspector' }
BlMetricsInspectorExamples >> elementWithMetrics [
	<gtExample>
	^ BlElement new
		margin: (BlInsets top: 1 right: 2 bottom: 3 left: 4);
		padding: (BlInsets top: 5 right: 6 bottom: 7 left: 8);
		size: 300@100;
		background: Color lightGray;
		border: (BlBorder paint: Color black width: 2).
]

{ #category : #'examples - inspector' }
BlMetricsInspectorExamples >> metricsInspectorOnElementWithMetrics [
	<gtExample>
	| anInspector anElement |
	anInspector := self basicMetricsInspector.
	anElement := self elementWithMetrics.
	anInspector for: anElement.
	self assert: anInspector childrenCount equals: 1.
	self assert: ((anInspector childAt: 1) childAt: 2) text asString equals: '1.0'.
	self assert: ((anInspector childAt: 1) childAt: 3) text asString equals: '2.0'.
	self assert: ((anInspector childAt: 1) childAt: 4) text asString equals: '3.0'.
	self assert: ((anInspector childAt: 1) childAt: 5) text asString equals: '4.0'.
	^ anInspector
]

{ #category : #'examples - inspector' }
BlMetricsInspectorExamples >> metricsInspectorOnUninitializedElement [
	<gtExample>
	| anInspector anElement |
	anInspector := self basicMetricsInspector.
	anElement := BlElement new.
	anInspector for: anElement.
	self assert: anInspector childrenCount equals: 1.
	self assert: ((anInspector childAt: 1) childAt: 1) text asString equals: 'margin'.
	self assert: ((anInspector childAt: 1) childAt: 2) text asString equals: '-'.
	^ anInspector
]

{ #category : #'examples - helpers' }
BlMetricsInspectorExamples >> metricsPhlowView [
	"<gtExample>"
	| anElement aPhlowClass aPhlow |
	anElement := self elementWithMetrics.
	aPhlowClass := self class environment at: #GtPhlowView ifAbsent: [ ^ self ].
	aPhlow := anElement gtMetricsFor: aPhlowClass empty.
	^ aPhlow
]

{ #category : #'examples - helpers' }
BlMetricsInspectorExamples >> title [
	^ '<Phlow is not installed>'
]
