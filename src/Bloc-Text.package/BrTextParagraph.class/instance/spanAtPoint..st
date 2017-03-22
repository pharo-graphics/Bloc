paragraph - geometry
spanAtPoint: aPoint
	<return: #BrTextparagraphSpan>
	
	^ self
		spanAtPoint: aPoint
		ifFound: #yourself
		ifNone: #yourself