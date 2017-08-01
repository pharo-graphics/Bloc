cursor - management
moveCursorAtPosition: aPoint in: aTextEditElement
	| aTextIndex |
	
	aTextIndex := aTextEditElement paragraph indexAtPosition: aPoint.
	self
		moveCursorTo: aTextIndex
		in: aTextEditElement