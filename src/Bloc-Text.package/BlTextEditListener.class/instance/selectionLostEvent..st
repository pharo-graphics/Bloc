selection handlers
selectionLostEvent: anEvent
	super selectionLostEvent: anEvent.
	
	anEvent target select: 0 to: 0