*Bloc-Sparta
applySpartaMetrics: aSpMetrics
	| aFontMetrics aTextMetrics iterator leadingSpace trailingSpaces |

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
	leadingSpace := 0.
	[ iterator hasNext and: [ iterator nextCharacter = Character space] ]
		whileTrue: [ leadingSpace := leadingSpace + aFontMetrics spaceWidth  ].

	left := left - leadingSpace.
	width := width + leadingSpace.