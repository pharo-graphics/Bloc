api - touch move
processTouchMove: aTouchMoveEvent
	self fireEvent: aTouchMoveEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aTouchMoveEvent target