event processing
generateEvents
	(isMouseStillDown ~= 0 and: [ currentDragTarget isNil ])
		ifTrue: [ self fireAsMouseStillDownEvent: lastMouseDownEvent ]