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
BlSpartaTextMeasurer >> canvas [
	^ self subclassResponsibility  
]

{ #category : #measurement }
BlSpartaTextMeasurer >> measureTextParagraph: aBlTextParagraph [
	aBlTextParagraph measureOn: self
]

{ #category : #measurement }
BlSpartaTextMeasurer >> measureTextSpan: aBlSpan [
	"Measure a given text span and return paragraph span with computed metrics"
	<return: #BlSpartaTextParagraphSpan>

	| fontBuilder fontAndStyleBuilder freeTypeFont textPainter attributes textRun spartaMetrics paragraphSpan |

	"we first collect font properties and text style from the attributes"
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	attributes := aBlSpan attributes.
	attributes do: [ :eachAttribute | eachAttribute applyOnFontAndStyleBuilder: fontAndStyleBuilder ].

	"build an abstract font and resolve not yet resolved properties"
	freeTypeFont := fontAndStyleBuilder font.
	textPainter := self canvas text.
	fontBuilder := self canvas font.

	freeTypeFont applyOnSpartaFontBuilder: fontBuilder.
	fontAndStyleBuilder applyOnSpartaTextPainter: textPainter.

	textPainter font: fontBuilder build.
	textPainter string: (String streamContents: [ :aStream | aBlSpan do: [ :anItem | anItem textRunOn: aStream ] ]).

	spartaMetrics := textPainter metrics.

	textRun := textPainter textRunWithMetrics: spartaMetrics.
	paragraphSpan := self createParagraphSpan.
	paragraphSpan applySpartaMetrics: spartaMetrics.
	paragraphSpan textRun: textRun.

	^ paragraphSpan
]
