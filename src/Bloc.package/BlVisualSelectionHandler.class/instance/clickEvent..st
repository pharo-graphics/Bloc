mouse handlers
clickEvent: anEvent
	| oldSelected |
	
	super clickEvent: anEvent.
	
	oldSelected := selected copy.
	selected removeAll.
	oldSelected keysDo: [ :anElement | self handleDeselected: anElement ]