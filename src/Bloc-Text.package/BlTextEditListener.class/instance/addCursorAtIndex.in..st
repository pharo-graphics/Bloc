adding
addCursorAtIndex: aTextIndex in: aTextEditElement
	self
		moveCursor: aTextEditElement addCursor
		to: aTextIndex
		in: aTextEditElement