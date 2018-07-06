instance creation
asParenthesesText: aString

	^ (BlRopedText string: aString)
		attributes: { BrFontWeightAttribute thin }