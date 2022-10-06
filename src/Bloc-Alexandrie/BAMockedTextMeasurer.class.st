Class {
	#name : #BAMockedTextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'ascent',
		'descent',
		'glyphWidth',
		'height',
		'measuredWidth',
		'measuredHeight',
		'textOffset'
	],
	#category : #'Bloc-Alexandrie-Text-Mocked'
}

{ #category : #accessing }
BAMockedTextMeasurer >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : #accessing }
BAMockedTextMeasurer >> ascent: aNumber [

	self
		assert: [ aNumber <= 0 ]
		description: [ 'Ascent must be negative' ].

	ascent := aNumber
]

{ #category : #accessing }
BAMockedTextMeasurer >> descent [
	<return: #Number>

	^ descent
]

{ #category : #accessing }
BAMockedTextMeasurer >> descent: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Descent must be positive' ].
	
	descent := aNumber
]

{ #category : #accessing }
BAMockedTextMeasurer >> glyphWidth [
	<return: #Number>

	^ glyphWidth
]

{ #category : #accessing }
BAMockedTextMeasurer >> glyphWidth: aNumber [
	glyphWidth := aNumber
]

{ #category : #accessing }
BAMockedTextMeasurer >> height [
	^ height
]

{ #category : #accessing }
BAMockedTextMeasurer >> height: aNumber [
	height := aNumber
]

{ #category : #initialization }
BAMockedTextMeasurer >> initialize [
	super initialize.

	ascent := -11.
	descent := 4.
	height := 13.
	glyphWidth := 5.
	textOffset := 0
]

{ #category : #measurement }
BAMockedTextMeasurer >> measureTextParagraph: aBlTextParagraph [

	aBlTextParagraph measureOn: self
]

{ #category : #measurement }
BAMockedTextMeasurer >> measureTextSpan: aBlSpan [

	"Measure a given text span and return paragraph span with my fixed metrics"

	measuredWidth := aBlSpan size * self glyphWidth.
	measuredHeight := self height * aBlSpan size isZero not asBit.

	^ self createParagraphSpan setupFromHostTextMeasurer: self forSpan: aBlSpan
]

{ #category : #metrics }
BAMockedTextMeasurer >> measuredHeight [
	^ measuredHeight
]

{ #category : #metrics }
BAMockedTextMeasurer >> measuredWidth [
	^ measuredWidth
]

{ #category : #'paragraph span instance creation' }
BAMockedTextMeasurer >> newParagraphSpan [
	^ BAMockedTextParagraphSpan new 
]

{ #category : #accessing }
BAMockedTextMeasurer >> textOffset [
	^ textOffset
]

{ #category : #accessing }
BAMockedTextMeasurer >> textOffset: aNumber [
	textOffset := aNumber
]
