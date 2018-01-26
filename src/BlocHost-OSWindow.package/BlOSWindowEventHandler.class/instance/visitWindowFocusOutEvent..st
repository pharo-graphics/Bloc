visiting window
visitWindowFocusOutEvent: anEvent
	^ BlSpaceFocusOutEvent new
		timestamp: DateAndTime now;
		yourself