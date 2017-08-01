dnd handlers
dragStartEvent: anEvent
	super dragStartEvent: anEvent.
	
	container addChild: selection