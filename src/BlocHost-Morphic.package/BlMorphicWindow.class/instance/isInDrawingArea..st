morphic events handling
isInDrawingArea: anEvent
	^ self layoutBounds containsPoint: anEvent position