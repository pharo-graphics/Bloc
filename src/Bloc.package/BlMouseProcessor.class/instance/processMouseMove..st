mouse move
processMouseMove: aMouseMoveEvent

	self fireEvent: aMouseMoveEvent.
	
	"now we can update the cursor from the target"
	self updateCursorFrom: aMouseMoveEvent target.
	
	self processMouseEnterExitEvent: aMouseMoveEvent