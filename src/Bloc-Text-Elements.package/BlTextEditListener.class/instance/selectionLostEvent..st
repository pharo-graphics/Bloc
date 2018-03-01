selection handlers
selectionLostEvent: anEvent
	super selectionLostEvent: anEvent.
	
	anEvent currentTarget border: (BlBorder empty).
	
	self selectNone: anEvent currentTarget