Class {
	#name : #BATextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'canvas'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #accessing }
BATextMeasurer >> canvas [
	"Return the Alexandrie canvas"

	^ canvas
]

{ #category : #accessing }
BATextMeasurer >> canvas: aeCanvas [

	canvas := aeCanvas
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
