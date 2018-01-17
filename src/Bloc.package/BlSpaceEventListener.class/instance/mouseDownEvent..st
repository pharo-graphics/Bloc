mouse handlers
mouseDownEvent: anEvent
	self mouseProcessor handleMouseDown: anEvent.
	self focusProcessor handleMouseDown: anEvent