visiting window
visitWindowMoveEvent: anEvent
	^ BlWindowMoveEvent new
		timestamp: Time millisecondClockValue;
		position: self window position;
		yourself