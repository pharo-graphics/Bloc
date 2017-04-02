initialization
text: aBrSubText from: aStartIndex to: anEndIndex
	text := aBrSubText.
	iterator := aBrSubText text iterator: aStartIndex + text start - 1 to: anEndIndex + text start - 1.