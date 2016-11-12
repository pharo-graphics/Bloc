visiting window
visitWindowFocusInEvent: anEvent
	^ BlSpaceFocusInEvent new
		timestamp: Time millisecondClockValue;
		yourself