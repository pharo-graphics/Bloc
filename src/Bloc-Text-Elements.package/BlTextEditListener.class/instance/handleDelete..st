keyboard handlers
handleDelete: anEvent
	
	self
		deleteAt: anEvent currentTarget cursorPosition + 1
		in: anEvent currentTarget