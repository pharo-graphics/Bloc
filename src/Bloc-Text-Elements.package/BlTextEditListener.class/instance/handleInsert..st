keyboard handlers
handleInsert: anEvent
	
	self
		insertString: anEvent char asString
		at: anEvent currentTarget cursorPosition
		in: anEvent currentTarget