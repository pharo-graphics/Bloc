instance creation
asParenthesesText: aString

	^ (BrRopedText string: aString)
		attributes: { BrFontWeightAttribute thin }