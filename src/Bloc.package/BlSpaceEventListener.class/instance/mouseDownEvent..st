mouse handlers
mouseDownEvent: anEvent
	self mouseProcessor processMouseDown: anEvent.
	self focusProcessor processMouseDown: anEvent