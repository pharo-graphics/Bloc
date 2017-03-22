mouse handlers
clickEvent: anEvent
	| aTextElement aParagraphSpan aTextIndex aClickPosition |
	
	aTextElement := anEvent currentTarget.
	aClickPosition := aTextElement globalPointToLocal: anEvent position.
	
	aParagraphSpan := aTextElement paragraph spanAtPoint: aClickPosition.
	aTextIndex := aParagraphSpan charAtPoint: aClickPosition.
	
	self
		moveCursorAt: aTextIndex
		of: aTextElement
		in: aParagraphSpan.

	aTextElement requestFocus