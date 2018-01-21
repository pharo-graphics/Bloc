event testing
canStartDrag: aMouseMoveEvent
	<return: #Boolean>

	^ (pressedButtons includes: BlMouseButton primary)
		and: [ previousMouseDownEvent isNotNil
			and: [ previousMouseDownEvent primaryButtonPressed
				and: [ (aMouseMoveEvent position - previousMouseDownEvent position) r > self startDragThreshold ] ] ]