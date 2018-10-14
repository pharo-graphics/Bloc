"
! Text baselines

${example:BlTextElementBaselineExamples>>#textElementWithAscentBaseline|expandedPreview|show=#gtLiveFor:|previewHeight=100}$
${example:BlTextElementBaselineExamples>>#textElementWithBoundsBaseline|expandedPreview|show=#gtLiveFor:|previewHeight=100}$
${example:BlTextElementBaselineExamples>>#baselineDifference|expandedPreview|show=#gtLiveFor:|previewHeight=110}$

"
Class {
	#name : #BlTextElementBaselineExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Text'
}

{ #category : #baselines }
BlTextElementBaselineExamples >> baselineDifference [
	<gtExample>
	| ascentTextElement boundsTextElement containerElement |

	ascentTextElement := self textElementWithAscentBaseline.
	boundsTextElement := self textElementWithBoundsBaseline.

	containerElement := BlElement new.
	containerElement clipChildren: false.
	containerElement layout: (BlGridLayout horizontal cellSpacing: 10).
	containerElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	containerElement addChildren: { ascentTextElement . boundsTextElement }.

	^ containerElement
]

{ #category : #example }
BlTextElementBaselineExamples >> textElementWithAscentBaseline [
	<gtExample>
	| textElement |
	
	textElement := BlTextElementExamples new textElement.
	textElement border: (BlBorder paint: (Color red alpha: 0.6) width: 2).
	textElement text
		background: (Color red alpha: 0.4);
		attribute: (BlTextUnderlineAttribute new paint: (Color red)).

	textElement ascentBaseline.

	self assert: textElement baseline equals: BlTextParagraphAscentBaseline uniqueInstance.

	^ textElement
]

{ #category : #example }
BlTextElementBaselineExamples >> textElementWithBoundsBaseline [
	<gtExample>
	| textElement |
	
	textElement := BlTextElementExamples new textElement.
	textElement border: (BlBorder paint: (Color blue alpha: 0.6) width: 2).
	textElement text
		background: (Color blue alpha: 0.4);
		attribute: (BlTextUnderlineAttribute new paint: (Color blue)).
	textElement boundsBaseline.

	self assert: textElement baseline equals: BlTextParagraphBoundsBaseline uniqueInstance.

	^ textElement
]
