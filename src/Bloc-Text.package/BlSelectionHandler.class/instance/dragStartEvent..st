dnd handlers
dragStartEvent: anEvent
	super dragStartEvent: anEvent.

	origin := anEvent position.

	container addChild: selection