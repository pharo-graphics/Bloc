dnd handlers
dragEndEvent: anEvent
	super dragEndEvent: anEvent.
	
	origin := nil.
	corner := nil.
	area left: 0 top: 0 right: 0 bottom: 0