event handling
handleWindowClosed: aMorphicEvent
	| aBlEvent |
	
	aBlEvent := BlSpaceCloseRequest new
		timestamp: DateAndTime now.
	
	self enqueue: aBlEvent