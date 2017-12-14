keyboard handlers
handleBackspace: anEvent
	
	self
		deleteAt: anEvent currentTarget cursorPosition
		in: anEvent currentTarget