focus handlers
focusEvent: anEvent
	super focusEvent: anEvent.

	anEvent currentTarget
		showCursor;
		background: (Color blue alpha: 0.05);
		border: (BlBorder paint: (Color blue alpha: 0.5) width: 1)