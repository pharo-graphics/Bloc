Extension { #name : #BlTextParagraphSpan }

{ #category : #'*Bloc-Sparta' }
BlTextParagraphSpan >> applySpartaMetrics: aSpMetrics [
	| aFontMetrics aTextMetrics iterator leadingSpaces |

	aFontMetrics := aSpMetrics fontMetrics.
	aTextMetrics := aSpMetrics textMetrics.

	ascent := aFontMetrics maxAscent.
	descent := aFontMetrics maxDescent.

	strikethroughOffset := aFontMetrics strikeoutOffset.
	strikethroughSize := aFontMetrics strikeoutSize.

	left := aTextMetrics left.
	top := aTextMetrics top.
	width := aTextMetrics width.
	height := aTextMetrics height.
	advance := aTextMetrics advance.
	baseline := 0@0.

	iterator := self textRun iterator.
	leadingSpaces := 0.
	[ iterator hasNext and: [ iterator nextCharacter = Character space] ]
		whileTrue: [ leadingSpaces := leadingSpaces + 1  ].

	width := width + (leadingSpaces * aFontMetrics spaceWidth).

	"If I only consist of spaces we should not move left"
	leadingSpaces = self textRunLength
		ifTrue: [ left := 0.0 ]
		ifFalse: [ left := left - (leadingSpaces * aFontMetrics spaceWidth) ]
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
		start: self textRunStart;
		end: self textRunEnd;
		baseline: self baseline;
		ensureFont;
		draw.

	"And finally let attributes to render above the text"
	theAttributes do: [ :anAttribute |
		anAttribute drawAboveOnSpartaCanvas: aCanvas with: self ]
]
