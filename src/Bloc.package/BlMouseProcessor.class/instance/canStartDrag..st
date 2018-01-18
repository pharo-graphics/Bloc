event testing
canStartDrag: aMouseMoveEvent
	<return: #Boolean>

	^ aMouseMoveEvent primaryButtonPressed
		and: [ previousMouseDownEvent isNotNil
			and: [ previousMouseDownEvent primaryButtonPressed
				and: [ (aMouseMoveEvent position - previousMouseDownEvent position) r > self startDragThreshold ] ] ]