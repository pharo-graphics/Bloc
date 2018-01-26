visiting window
visitWindowMouseLeaveEvent: anEvent
	^ BlSpaceMouseLeaveEvent new
		timestamp: DateAndTime now;
		yourself