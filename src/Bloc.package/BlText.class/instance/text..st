accessing
text: aString
	
	textModel := aString asTxModel.
	self updateTextModel.
	
	layoutView
		initWithStrategy: layoutView layoutStrategy
		position: textModel startPosition
		extent: 100 @ 100