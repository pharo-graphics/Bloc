event testing
canBeDragEvent: aMouseMoveEvent
	^ isMouseStillDown ~= 0 and:
		[ ((isMouseStillDown bitAnd: dragStartMask) = dragStartMask) and:
		[ (aMouseMoveEvent position - lastMouseDownEvent position) r > self startDragThreshold ] ]
		