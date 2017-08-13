mouse handlers
mouseDownEvent: anEvent
	| oldSelected |
	super mouseDownEvent: anEvent.
	
	oldSelected := selected copy.
	selected removeAll.
	oldSelected keysDo: [ :anElement | self handleDeselected: anElement ]