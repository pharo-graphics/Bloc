"
I am an element metrics inspector and give a summary of target's bounds, margin border and padding
"
Class {
	#name : #BlMetricsInspector,
	#superclass : #BlElement,
	#instVars : [
		'marginMetric',
		'paddingMetric',
		'extentMetric'
	],
	#category : 'Bloc-DevTool-Metrics'
}

{ #category : #initialization }
BlMetricsInspector >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'instance creation' }
BlMetricsInspector >> extentTextFor: aPoint [
	| string |
	
	string := (aPoint x printShowingDecimalPlaces: 3), ' x ', (aPoint y printShowingDecimalPlaces: 3).
	^ BlRopedText string: string
]

{ #category : #initialization }
BlMetricsInspector >> for: anElement [	
	anElement forceLayout.
	self updateMetrics: anElement
]

{ #category : #initialization }
BlMetricsInspector >> initialize [
	super initialize.
	
	extentMetric := self newExtentMetric.
	extentMetric padding: (BlInsets top: 15 right: 55 bottom: 15 left: 55).
	extentMetric text: ('content' asRopedText attributes: {
		BrFontFamilyAttribute named: 'Helvetica Neue'.
		BrFontEmphasisAttribute italic.
		BrFontSizeAttribute size: 15
	}).
	extentMetric background: Color white.

	paddingMetric := self newMetric.
	paddingMetric label: 'padding'.
	paddingMetric border: (BlBorder builder paint: (Color black alpha: 0.7); width: 2; build).
	paddingMetric background: (Color paleGreen lighter).
	paddingMetric content: extentMetric.

	marginMetric := self newMetric.
	marginMetric label: 'margin'.
	marginMetric background: (Color paleOrange lighter).
	marginMetric content: paddingMetric.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self addChild: marginMetric
]

{ #category : #'instance creation' }
BlMetricsInspector >> newExtentMetric [
	^ BlTextElement new
]

{ #category : #'instance creation' }
BlMetricsInspector >> newMetric [
	^ BlMetricsInspectorElement new
]

{ #category : #updating }
BlMetricsInspector >> updateMetrics: anElement [
	| geometryBounds |
	
	geometryBounds := anElement geometryBounds.	
	marginMetric insets: anElement margin.
	paddingMetric insets: anElement padding.
]
