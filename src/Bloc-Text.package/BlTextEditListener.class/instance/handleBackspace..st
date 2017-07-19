keyboard handlers
handleBackspace: anEvent
	
	self
		deleteAt: anEvent currentTarget cursor textIndex
		in: anEvent currentTarget