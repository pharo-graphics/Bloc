Extension { #name : #BlTextParagraphSpan }

{ #category : #'*Bloc-Sparta' }
BlTextParagraphSpan >> applySpartaMetrics: aSpMetrics [
	| aFontMetrics aTextMetrics |

	aFontMetrics := aSpMetrics fontMetrics.
	aTextMetrics := aSpMetrics textMetrics.

	isVertical := false.

	ascent := aFontMetrics ascent.
	descent := aFontMetrics descent.

	strikethroughOffset := aFontMetrics strikeoutOffset.
	strikethroughSize := aFontMetrics strikeoutSize.

	left :=  aTextMetrics left.
	top := isVertical
		ifTrue: [ aTextMetrics left ]
		ifFalse: [ aTextMetrics top ].
	width := isVertical
		ifTrue: [ aTextMetrics height ]
		ifFalse: [ aTextMetrics width ].
	height := isVertical
		ifTrue: [ aTextMetrics width ]
		ifFalse: [ aTextMetrics height ].
	
	advance := aTextMetrics advance.
	baseline := 0@0
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraphSpan >> drawOnSpartaCanvas: aCanvas [
	| theAttributes aTextPainter |

	theAttributes := self attributes.

	aTextPainter := aCanvas text.
	theAttributes
		do: [ :anAttribute |
			anAttribute drawBelowOnSpartaCanvas: aCanvas with: self.
			anAttribute applyOnSpartaTextPainter: aTextPainter with: self ].

	aTextPainter
		text: self textRun;
		baseline: self baseline;
		ensureFont;
		draw.

	"And finally let attributes to render above the text"
	theAttributes do: [ :anAttribute |
		anAttribute drawAboveOnSpartaCanvas: aCanvas with: self ]
]
