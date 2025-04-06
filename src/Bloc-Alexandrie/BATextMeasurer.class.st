Class {
	#name : #BATextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'lineAdvance',
		'aeCanvas'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #accessing }
BATextMeasurer >> canvas [
	"Return the Alexandrie canvas"

	^ aeCanvas
]

{ #category : #accessing }
BATextMeasurer >> canvas: anAeCanvas [

	aeCanvas := anAeCanvas
]

{ #category : #dispatch }
BATextMeasurer >> measureTextParagraph: aBlTextParagraph [

	aBlTextParagraph measureOn: self
]

{ #category : #measurement }
BATextMeasurer >> measureTextSpan: aBlSpan [
	"Measure a given text span and return paragraph span with computed metrics"

	^ self newParagraphSpanFor: aBlSpan
]

{ #category : #'paragraph span instance creation' }
BATextMeasurer >> newParagraphSpan [
	^ BATextParagraphSpan new
]
