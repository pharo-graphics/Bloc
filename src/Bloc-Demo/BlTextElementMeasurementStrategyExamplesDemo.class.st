Class {
	#name : #BlTextElementMeasurementStrategyExamplesDemo,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'baselines - demo' }
BlTextElementMeasurementStrategyExamplesDemo >> measurementDifference [
	<gtExample>
	| ascentTextElement boundsTextElement editorTextElement containerElement |

	ascentTextElement := self textElementWithLabelMeasurement.
	boundsTextElement := self textElementWithTightMeasurement.
	editorTextElement := self textElementWithEditorMeasurement.

	containerElement := BlElement new.
	containerElement clipChildren: false.
	containerElement layout: (BlGridLayout horizontal cellSpacing: 10; columnCount: 2).
	containerElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	containerElement addChildren: { ascentTextElement . boundsTextElement . editorTextElement }.

	^ containerElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementStrategyExamplesDemo >> textElementWithEditorMeasurement [
	<gtExample>

	| textElement |
	textElement := BlTextElementExamples new textElement.
	textElement border:
		(BlBorder paint: (Color red darker alpha: 0.6) width: 1).
	textElement text
		background: (Color red alpha: 0.4);
		underline.

	textElement editorMeasurement.

	self
		assert: textElement baselineMeasurer
		equals: BlAscentLooseBaselineMeasurer uniqueInstance.
	self
		assert: textElement measurement
		equals: BlTextElementEditorMeasurementStrategy uniqueInstance.

	^ textElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementStrategyExamplesDemo >> textElementWithLabelMeasurement [
	<gtExample>

	| textElement |
	textElement := BlTextElementExamples new textElement.
	textElement border:
		(BlBorder paint: (Color red darker alpha: 0.6) width: 1).
	textElement text
		background: (Color red alpha: 0.4);
		underline.

	textElement labelMeasurement.

	self
		assert: textElement baselineMeasurer
		equals: BlAscentTightBaselineMeasurer uniqueInstance.

	"This assertion is counter-intuitive, but has a reason.
	See: https://github.com/pharo-graphics/Bloc/issues/263"
	self
		assert: textElement measurement
		equals: BlTextElementEditorMeasurementStrategy uniqueInstance.

	^ textElement
]

{ #category : #'example - demo' }
BlTextElementMeasurementStrategyExamplesDemo >> textElementWithTightMeasurement [
	<gtExample>

	| textElement |
	textElement := BlTextElementExamples new textElement.
	textElement border:
		(BlBorder paint: (Color blue darker alpha: 0.6) width: 1).
	textElement text
		background: (Color blue alpha: 0.4);
		underline.

	textElement tightMeasurement.

	self
		assert: textElement baselineMeasurer
		equals: BlBoundsBaselineMeasurer uniqueInstance.
	self
		assert: textElement measurement
		equals: BlTextElementTightMeasurementStrategy uniqueInstance.

	^ textElement
]
