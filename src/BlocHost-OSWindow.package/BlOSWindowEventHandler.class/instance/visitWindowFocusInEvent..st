visiting window
visitWindowFocusInEvent: anEvent
	^ BlSpaceFocusInEvent new
		timestamp: DateAndTime now;
		yourself