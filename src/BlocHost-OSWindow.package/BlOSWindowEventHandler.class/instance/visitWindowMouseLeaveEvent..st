visiting window
visitWindowMouseLeaveEvent: anEvent
	^ BlWindowMouseLeaveEvent new
		timestamp: Time millisecondClockValue;
		yourself