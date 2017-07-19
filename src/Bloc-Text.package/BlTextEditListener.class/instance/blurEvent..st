focus handlers
blurEvent: anEvent
	super blurEvent: anEvent.
	
	anEvent currentTarget
		hideCursor;
		border: BlBorder empty;
		background: BlBackground transparent