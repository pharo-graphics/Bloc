focus handlers
blurEvent: anEvent
	super blurEvent: anEvent.
	
	anEvent currentTarget hideCursor