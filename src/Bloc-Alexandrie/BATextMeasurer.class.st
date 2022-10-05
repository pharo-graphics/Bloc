Class {
	#name : #BATextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'lineAdvance'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #accessing }
BATextMeasurer >> canvas [

	^ self subclassResponsibility
]

{ #category : #dispatch }
BATextMeasurer >> measureTextParagraph: aBlTextParagraph [

	aBlTextParagraph measureOn: self
]

{ #category : #measurement }
BATextMeasurer >> measureTextSpan: aBlSpan [

	"Measure a given text span and return paragraph span with computed metrics"

	| fontAndStyleBuilder attributes |
	"Collect font properties and text style from the attributes"
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	attributes := aBlSpan attributes.
	attributes do: [ :eachAttribute | eachAttribute applyOnFontAndStyleBuilder: fontAndStyleBuilder ].
	^ self createParagraphSpan
		  span: aBlSpan fontAndStyleBuilder: fontAndStyleBuilder;
		  updateMetrics;
		  yourself
]

{ #category : #'paragraph span instance creation' }
BATextMeasurer >> newParagraphSpan [
	^ BATextParagraphSpan new
]
