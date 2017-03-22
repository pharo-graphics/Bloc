paragraph - geometry
spanAtPoint: aPoint ifFound: aFoundBlock ifNone: anExceptionBlock
	"Find a paragraph span that contains a given point given in a paragraph coordinates
	and evaluate a found block if such span was found or evaluate an exception block
	with the closed span to a point"
	<return: #BrTextparagraphSpan>
	
	^ self subclassResponsibility