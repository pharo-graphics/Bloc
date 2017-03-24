focus handlers
focusEvent: anEvent
	super focusEvent: anEvent.

	anEvent currentTarget
		showCursors;
		border: (BlBorder paint: Color blue width: 1)