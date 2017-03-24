focus handlers
blurEvent: anEvent
	super blurEvent: anEvent.
	
	anEvent currentTarget
		hideCursors;
		border: BlBorder empty