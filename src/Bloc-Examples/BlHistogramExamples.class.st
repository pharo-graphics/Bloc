"
# Histogram
A histogram is an accurate representation of the distribution of numerical data. It is an estimate of the probability distribution of a continuous variable and was first introduced by Karl Pearson. It differs from a bar graph, in the sense that a bar graph relates two variables, but a histogram relates only one.

The bins (intervals) are adjacent.

<https://en.wikipedia.org/wiki/Histogram>

By default, {{gtClass:BlHistogram}} is set up to represent a symmetric, unimodal distribution:
{{gtExample:BlHistogramExamples>>#default|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

## Orientation

The orientation of the histogram can be changed by sending a corresponding message

### Bottom to top
{{gtMethod:BlHistogram>>#beBottomToTop}} (which is a default orientation):
{{gtExample:BlHistogramExamples>>#bottomToTop|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

### Top to bottom
{{gtMethod:BlHistogram>>#beTopToBottom}}
{{gtExample:BlHistogramExamples>>#topToBottom|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

### Left to right
{{gtMethod:BlHistogram>>#beLeftToRight}}
{{gtExample:BlHistogramExamples>>#leftToRight|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

### Right to left
{{gtMethod:BlHistogram>>#beRightToLeft}}
{{gtExample:BlHistogramExamples>>#rightToLeft|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

"
Class {
	#name : #BlHistogramExamples,
	#superclass : #BlGeometryExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #examples }
BlHistogramExamples >> bottomToTop [
	<gtExample>
	| aHistogram |
	
	aHistogram := BlHistogram new
		beBottomToTop;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).

	^ aHistogram
]

{ #category : #examples }
BlHistogramExamples >> default [
	<gtExample>
	| aHistogram |
	
	aHistogram := BlHistogram new.
	
	self assert: aHistogram extent equals: 150@100.
	self assert: aHistogram values equals: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	self assert: aHistogram isBottomToTop.
	self assert: aHistogram isTopToBottom not.
	self assert: aHistogram isRightToLeft not.
	self assert: aHistogram isLeftToRight not.
	self assert: aHistogram computeOrigin equals: 0@100.
	self assert: aHistogram computeDelta equals: 15@0.
	self assert: aHistogram computeLengthVector equals: 0@(-1).

	^ aHistogram
]

{ #category : #examples }
BlHistogramExamples >> leftToRight [
	<gtExample>
	| aHistogram |
	
	aHistogram := BlHistogram new
		beLeftToRight;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).

	^ aHistogram
]

{ #category : #examples }
BlHistogramExamples >> rightToLeft [
	<gtExample>
	| aHistogram |
	
	aHistogram := BlHistogram new
		beRightToLeft;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).

	^ aHistogram
]

{ #category : #examples }
BlHistogramExamples >> topToBottom [
	<gtExample>
	| aHistogram |
	
	aHistogram := BlHistogram new
		beTopToBottom;
		values: #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).

	^ aHistogram
]
