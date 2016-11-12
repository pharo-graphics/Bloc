visiting window
visitWindowMoveEvent: anEvent
	^ BlSpaceMoveEvent new
		timestamp: Time millisecondClockValue;
		position: self window position;
		yourself