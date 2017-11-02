selection handlers
selectionLostEvent: anEvent
	super selectionLostEvent: anEvent.
	
	self selectNone: anEvent target