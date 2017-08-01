dnd handlers
dragEndEvent: anEvent
	super dragEndEvent: anEvent.
	
	container removeChild: selection