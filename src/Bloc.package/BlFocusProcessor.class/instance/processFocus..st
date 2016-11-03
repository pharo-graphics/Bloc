focus request
processFocus: anEvent
	self fireAsFocusInEvent: anEvent.
	self fireAsFocusEvent: anEvent.
	
	lastFocusOwner := anEvent target.
	self space focusOwner: lastFocusOwner.
	lastFocusOwner focused: true.