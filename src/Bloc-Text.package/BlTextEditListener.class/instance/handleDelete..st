keyboard handlers
handleDelete: anEvent
	
	self
		deleteAt: anEvent currentTarget cursor cursorPosition + 1
		in: anEvent currentTarget