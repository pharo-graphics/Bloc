event handling
handleWindowClose: aMorphicEvent
	| aBlEvent |
	
	aBlEvent := BlSpaceCloseEvent new
		timestamp: Time millisecondClockValue.
	
	self enqueue: aBlEvent