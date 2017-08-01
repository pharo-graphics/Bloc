keyboard handlers
handleBackspace: anEvent
	
	self
		deleteAt: anEvent currentTarget cursor cursorPosition
		in: anEvent currentTarget