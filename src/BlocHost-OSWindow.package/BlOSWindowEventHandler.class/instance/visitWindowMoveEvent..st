visiting window
visitWindowMoveEvent: anEvent
	^ BlSpaceMovedEvent new
		timestamp: DateAndTime now;
		position: self window position;
		yourself