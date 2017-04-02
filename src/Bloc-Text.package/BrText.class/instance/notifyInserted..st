text - notifications
notifyInserted: anInterval
	self dispatchEvent: (BrTextInsertedEvent new
		start: anInterval first;
		length: anInterval size)