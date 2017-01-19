accessing
visitDeleteEvent: aGdkEvent
	| evt |
	evt := BlSpaceCloseEvent new timestamp: Time millisecondClockValue.
	self hostSpace enqueueEvent: evt