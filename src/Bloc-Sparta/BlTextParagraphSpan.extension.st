Extension { #name : #BlTextParagraphSpan }

{ #category : #'*Bloc-Sparta' }
BlTextParagraphSpan >> applySpartaMetrics: aSpMetrics [

	| aFontMetrics aTextMetrics |
	baseline := 0@0.

	"Set font metrics (which are independendent from the particular string)"
	aFontMetrics := aSpMetrics fontMetrics.
	ascent := aFontMetrics ascent.
	descent := aFontMetrics descent.
	strikethroughOffset := aFontMetrics strikeoutOffset.
	strikethroughSize := aFontMetrics strikeoutSize.

	"Set text metrics (which are particular to a string)"
	aTextMetrics := aSpMetrics textMetrics.
	left :=  aTextMetrics left.
	top := aTextMetrics top.
	width := aTextMetrics width.
	height := aTextMetrics height.
	advance := aTextMetrics advance.

]

{ #category : #'*Bloc-Sparta' }
BlTextParagraphSpan >> drawOnSpartaCanvas: aCanvas [
	| theAttributes aTextPainter |
	theAttributes := self attributes.
	aTextPainter := aCanvas text.
	theAttributes
		do: [ :anAttribute | 
			anAttribute drawBelowOnSpartaCanvas: aCanvas with: self.
			anAttribute applyOnSpartaTextPainter: aTextPainter ].
	aTextPainter
		text: self textRun;
		baseline: self baseline;
		ensureFont;
		draw.

	"And finally let attributes to render above the text"
	theAttributes
		do:
			[ :anAttribute | anAttribute drawAboveOnSpartaCanvas: aCanvas with: self ]
]
