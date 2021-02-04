Class {
	#name : #BlSpartaTextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'spaceRenderer'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #dispatch }
BlSpartaTextMeasurer >> createParagraphSpan [
	<return: #BlTextParagraphSpan>

	^ BlTextParagraphSpan new measurer: self
]

{ #category : #dispatch }
BlSpartaTextMeasurer >> measureTextParagraph: aBlTextParagraph [
	aBlTextParagraph measureOn: self
]

{ #category : #dispatch }
BlSpartaTextMeasurer >> measureTextSpan: aBlSpan [
	"Measure a given text span and return paragraph span with computed metrics"
	<return: #BlTextParagraphSpan>
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
