selection - handling
selectionChanged
	super selectionChanged.

	selection
		relocate: self selectionArea origin;
		size: self selectionArea extent