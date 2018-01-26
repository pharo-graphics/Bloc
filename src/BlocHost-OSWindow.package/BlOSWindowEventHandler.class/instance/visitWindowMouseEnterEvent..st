visiting window
visitWindowMouseEnterEvent: anEvent
	^ BlSpaceMouseEnterEvent new
		timestamp: DateAndTime now;
		yourself