*Bloc-Sparta
applySpartaMetrics: aSpMetrics
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