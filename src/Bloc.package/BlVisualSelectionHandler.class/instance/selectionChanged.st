selection - handling
selectionChanged
	| aSelectionBounds |
	super selectionChanged.
	
	aSelectionBounds := BlBounds fromRectangle: ((origin min: corner) corner: (corner max: origin)).
	aSelectionBounds := container globalBoundsToLocal: aSelectionBounds.

	selection
		relocate: aSelectionBounds origin;
		size: aSelectionBounds extent