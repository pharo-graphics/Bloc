visiting window
visitWindowMouseLeaveEvent: anEvent
	^ BlSpaceMouseLeaveEvent new
		timestamp: Time millisecondClockValue;
		yourself