keyboard handlers
handleDelete: anEvent
	
	self
		deleteAt: anEvent currentTarget cursor textIndex + 1
		in: anEvent currentTarget