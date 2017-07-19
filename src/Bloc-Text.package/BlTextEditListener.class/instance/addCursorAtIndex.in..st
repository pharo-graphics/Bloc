cursor - management
addCursorAtIndex: aTextIndex in: aTextEditElement	
	aTextEditElement showCursor.
	self
		moveCursorTo: aTextIndex
		in: aTextEditElement