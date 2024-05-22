"
# Text measurement strategies

`BlTextElement` provides different text measurement strategies, each suitable for a specific use case. There is no perfect strategy, therefore understanding the differences between them is an important step in learning how to work with Text in Bloc.

## Label measurement

The default text measurement strategy is so called `Label measurement`, `BlTextElement>>#labelMeasurement`. The height of the text element in this case is a sum of ascent and descent which is given by the font. It means that the height of the text is independent from the content. The width is given by the exact bounds of the element's text. `Label measurement` is useful for displaying labels and short pieces of text. Please note, that since the width is precise and depends on the content, whitespace is not taken into account when computing the width of the text element.
{{gtExample:BlTextElementMeasurementStrategyExamples>>#textElementWithLabelMeasurement|noCode|previewShow=#gtLiveFor:|previewHeight=100}}

## Editor measurement

A similar measurement strategy which is designed to be used in a text editor computes the width of the element using the `#advance` property of a text paragraph. The height is computed as a sum of ascent and descent. `BlTextElement>>#editorMeasurement`
{{gtExample:BlTextElementMeasurementStrategyExamples>>#textElementWithEditorMeasurement|noCode|previewShow=#gtLiveFor:|previewHeight=100}}

## Precise measurement

However, sometimes we want to know the exact and precise text bounds. `BlTextElement>>#tightMeasurement` does exactly that and clips off any white space surrounding the text. It may be useful for displaying a short piece of a text, usually a word centered within a larger element.
{{gtExample:BlTextElementMeasurementStrategyExamples>>#textElementWithTightMeasurement|noCode|previewShow=#gtLiveFor:|previewHeight=75}}

## Conslusion

Now let's compare all text measurement strategies:
{{gtExample:BlTextElementMeasurementStrategyExamples>>#measurementDifference|noCode|previewShow=#gtLiveFor:|previewHeight=220}}


"
Class {
	#name : #BlTextElementMeasurementStrategyExamplesTest,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Text-Alexandrie-Examples'
}

{ #category : #example }
BlTextElementMeasurementStrategyExamplesTest >> measurementDifference [
	<sampleInstance>

	| ascentTextElement boundsTextElement editorTextElement containerElement |
	ascentTextElement := self textElementWithLabelMeasurement.
	boundsTextElement := self textElementWithTightMeasurement.
	editorTextElement := self textElementWithEditorMeasurement.

	containerElement := BlElement new.
	containerElement clipChildren: false.
	containerElement layout: (BlGridLayout horizontal
			 cellSpacing: 10;
			 columnCount: 2).
	containerElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	containerElement addChildren: {
			ascentTextElement.
			boundsTextElement.
			editorTextElement }.

	^ containerElement
]

{ #category : #private }
BlTextElementMeasurementStrategyExamplesTest >> newTextElement [

	| text |
	text := 'mama' asRopedText.
	text fontSize: 80.
	^ BlTextElement new
		text: text;
		clipChildren: false;
		yourself
]

{ #category : #example }
BlTextElementMeasurementStrategyExamplesTest >> textElementWithEditorMeasurement [
	<sampleInstance>

	| textElement |
	textElement := self newTextElement.
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

{ #category : #example }
BlTextElementMeasurementStrategyExamplesTest >> textElementWithLabelMeasurement [
	<sampleInstance>

	| textElement |
	textElement := self newTextElement.
	textElement border:
		(BlBorder paint: (Color green darker alpha: 0.6) width: 1).
	textElement text
		background: (Color green alpha: 0.4);
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

{ #category : #example }
BlTextElementMeasurementStrategyExamplesTest >> textElementWithTightMeasurement [
	<sampleInstance>

	| textElement |
	textElement := self newTextElement.
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
