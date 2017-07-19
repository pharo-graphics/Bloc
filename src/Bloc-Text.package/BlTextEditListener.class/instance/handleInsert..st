keyboard handlers
handleInsert: anEvent
	
	self
		insertString: anEvent char asString
		at: anEvent currentTarget cursor textIndex
		in: anEvent currentTarget