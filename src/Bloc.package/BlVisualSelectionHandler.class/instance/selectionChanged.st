selection - handling
selectionChanged
	| aSelectionBounds |
	super selectionChanged.

	aSelectionBounds := container globalBoundsToLocal: self selectionArea copy.

	selection
		relocate: aSelectionBounds origin;
		size: aSelectionBounds extent