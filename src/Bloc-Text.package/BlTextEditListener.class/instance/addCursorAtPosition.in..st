cursor - management
addCursorAtPosition: aPoint in: aTextEditElement
	| aTextIndex |
	
	aTextIndex := aTextEditElement paragraph charAtPoint: aPoint.
	self
		moveCursor: aTextEditElement addCursor
		to: aTextIndex
		in: aTextEditElement