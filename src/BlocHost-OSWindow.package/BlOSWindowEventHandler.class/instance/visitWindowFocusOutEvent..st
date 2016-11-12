visiting window
visitWindowFocusOutEvent: anEvent
	^ BlSpaceFocusOutEvent new
		timestamp: Time millisecondClockValue;
		yourself