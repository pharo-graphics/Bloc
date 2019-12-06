Class {
	#name : #BlMetricsInspectorExample,
	#superclass : #BlElement,
	#category : #'Bloc-DevTool-Metrics'
}

{ #category : #'examples - inspector' }
BlMetricsInspectorExample >> basicMetricsInspector [
	<gtExample>
	| anInspector |
	anInspector := BlMetricsInspector new.
	self assert: anInspector childrenCount equals: 1.
	^ anInspector
]

{ #category : #'examples - inspector' }
BlMetricsInspectorExample >> elementWithMetrics [
	<gtExample>
	^ BlElement new
		margin: (BlInsets top: 1 right: 2 bottom: 3 left: 4);
		padding: (BlInsets top: 5 right: 6 bottom: 7 left: 8);
		size: 300@100;
		background: Color lightGray;
		border: (BlBorder paint: Color black width: 2).
]

{ #category : #'examples - inspector' }
BlMetricsInspectorExample >> metricsInspectorOnElementWithMetrics [
	<gtExample>
	| anInspector anElement |
	anInspector := self basicMetricsInspector.
	anElement := self elementWithMetrics.
	anInspector for: anElement.
	self assert: anInspector childrenCount equals: 1.
	self assert: ((anInspector childAt: 1) childAt: 2) text asString equals: '1'.
	self assert: ((anInspector childAt: 1) childAt: 3) text asString equals: '2'.
	self assert: ((anInspector childAt: 1) childAt: 4) text asString equals: '3'.
	self assert: ((anInspector childAt: 1) childAt: 5) text asString equals: '4'.
	^ anInspector
]

{ #category : #'examples - inspector' }
BlMetricsInspectorExample >> metricsInspectorOnUninitializedElement [
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
BlMetricsInspectorExample >> metricsPhlowView [
	<gtExample>
	| anElement aPhlowClass aPhlow |
	anElement := self elementWithMetrics.
	aPhlowClass := self class environment at: #GtPhlowView ifAbsent: [ ^ nil ].
	aPhlow := anElement gtMetricsFor: aPhlowClass empty.
	^ aPhlow
]

{ #category : #'examples - helpers' }
BlMetricsInspectorExample >> metricsPhlowViewTitle [
	<gtExample>
	| aPhlow |
	aPhlow := self metricsPhlowView.
	aPhlow ifNil: [ ^ '<Phlow is not installed>' ].
	^ aPhlow title value asString
]
