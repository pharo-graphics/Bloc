focus handlers
focusEvent: anEvent
	super focusEvent: anEvent.

	anEvent currentTarget
		showCursor