dnd handlers
dragEndEvent: anEvent
	super dragEndEvent: anEvent.
	
	origin := nil.
	container removeChild: selection