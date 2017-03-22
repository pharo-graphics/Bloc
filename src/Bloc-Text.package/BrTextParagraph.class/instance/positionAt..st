paragraph - geometry
positionAt: anIndex
	<return: #Point>
	| aParagraphSpan |
	
	aParagraphSpan := self spanAtIndex: anIndex.
	^ aParagraphSpan positionAt: anIndex