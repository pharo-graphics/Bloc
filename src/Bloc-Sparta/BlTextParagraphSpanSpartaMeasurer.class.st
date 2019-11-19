"
I measure a text span in a context of sparta canvas
"
Class {
	#name : #BlTextParagraphSpanSpartaMeasurer,
	#superclass : #BlTextParagraphSpanMeasurer,
	#category : #'Bloc-Sparta-Text'
}

{ #category : #measurement }
BlTextParagraphSpanSpartaMeasurer >> measureSpan: aBlSpan on: aSpartaCanvas [
	"Measure a given text span and return paragraph span with computed metrics"
	<return: #BlTextParagraphSpan>
	| aFontBuilder aTextPainter theAttributes aTextRun aSpartaMetrics aParagraphSpan |

	theAttributes := aBlSpan attributes.

	aTextPainter := aSpartaCanvas text.
	aFontBuilder := aSpartaCanvas font.

	theAttributes do: [ :anAttribute |
		anAttribute applyOnSpartaFontBuilder: aFontBuilder with: aBlSpan.
		anAttribute applyOnSpartaTextPainter: aTextPainter with: aBlSpan ].

	aTextPainter font: aFontBuilder build.
	aTextPainter string: (String streamContents: [ :aStream |
		aBlSpan do: [ :anItem | anItem textRunOn: aStream ] ]).
	
	aSpartaMetrics := SpartaMetrics new.
	aTextRun := aTextPainter textRunWithMetrics: aSpartaMetrics.

	self
		assert: [ aTextRun isNull not ]
		description: [ 'Created text run must not be nullptr' ].

	aParagraphSpan := self createParagraphSpan.
	aParagraphSpan applySpartaMetrics: aSpartaMetrics.
	aParagraphSpan textRun: aTextRun
		start: (1 min: aTextRun size)
		end: aTextRun size.
	
	^ aParagraphSpan
]
