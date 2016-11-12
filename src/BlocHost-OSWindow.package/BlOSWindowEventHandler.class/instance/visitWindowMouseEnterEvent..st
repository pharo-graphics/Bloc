visiting window
visitWindowMouseEnterEvent: anEvent
	^ BlSpaceMouseEnterEvent new
		timestamp: Time millisecondClockValue;
		yourself