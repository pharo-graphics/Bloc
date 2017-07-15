cursor - management
moveCursorAtPosition: aPoint in: aTextEditElement
	| aTextIndex |
	
	aTextIndex := aTextEditElement paragraph charAtPoint: aPoint.
	self
		moveCursorTo: aTextIndex
		in: aTextEditElement