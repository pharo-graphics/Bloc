"
I know how to measure the bounds of a text paragraph in a SpartaCanvas.

My subclasses need to implement #spartaCanvas template method to provide the (sub)instance of SpartaCanvas that will be used to measure.
"
Class {
	#name : #BlSpartaTextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'spaceRenderer'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #accessing }
BlSpartaTextMeasurer >> createParagraphSpan [
	<return: #BlSpartaTextParagraphSpan>

	^ BlSpartaTextParagraphSpan new
		  measurer: self;
		  yourself
]

{ #category : #measurement }
BlSpartaTextMeasurer >> measureTextParagraph: aBlTextParagraph [
	aBlTextParagraph measureOn: self
]

{ #category : #measurement }
BlSpartaTextMeasurer >> measureTextSpan: aBlSpan [
	"Measure a given text span and return paragraph span with computed metrics"
	<return: #BlSpartaTextParagraphSpan>

	| aFontBuilder aFontAndStyleBuilder aFont aTextPainter theAttributes aTextRun aSpartaMetrics aParagraphSpan |

	"we first collect font properties and text style from the attributes"
	aFontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	
	theAttributes := aBlSpan attributes.
	theAttributes do: [ :eachAttribute | eachAttribute applyOnFontAndStyleBuilder: aFontAndStyleBuilder ].

	"build an abstract font and resolve not yet resolved properties"
	aFont := aFontAndStyleBuilder font.

	aTextPainter := self spartaCanvas text.
	aFontBuilder := self spartaCanvas font.

	aFont applyOnSpartaFontBuilder: aFontBuilder.
	aFontAndStyleBuilder applyOnSpartaTextPainter: aTextPainter.

	aTextPainter font: aFontBuilder build.
	aTextPainter string: (String streamContents: [ :aStream | aBlSpan do: [ :anItem | anItem textRunOn: aStream ] ]).

	aSpartaMetrics := aTextPainter metrics.

	aTextRun := aTextPainter textRunWithMetrics: aSpartaMetrics.
	self
		assert: [ aTextRun isNull not ]
		description: [ 'Created text run must not be nullptr' ].

	aParagraphSpan := self createParagraphSpan.
	aParagraphSpan applySpartaMetrics: aSpartaMetrics.
	aParagraphSpan textRun: aTextRun.

	^ aParagraphSpan
]

{ #category : #accessing }
BlSpartaTextMeasurer >> spartaCanvas [
	^ self subclassResponsibility
]
