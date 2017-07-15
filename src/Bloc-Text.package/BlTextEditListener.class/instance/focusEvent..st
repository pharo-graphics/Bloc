focus handlers
focusEvent: anEvent
	super focusEvent: anEvent.

	anEvent currentTarget
		showCursor;
		border: (BlBorder paint: (Color blue alpha: 0.5) width: 1)