event firing
sendEvent: anEvent
	anEvent timestamp: DateAndTime now.
	space eventListener handleEvent: anEvent