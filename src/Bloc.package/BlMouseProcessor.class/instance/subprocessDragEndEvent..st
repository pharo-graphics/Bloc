event processing
subprocessDragEndEvent: anEvent
	(currentDragTarget isNotNil and: [ (isMouseStillDown bitAnd: dragStartMask) ~= dragStartMask ])
		ifTrue: [ 
			
			self fireAsDragEndEvent: anEvent.
			self fireAsDropEvent: anEvent.
			self space deleteDragboard.
			currentDragTarget := nil.
			lastOverTarget := nil.
			dragStartMask := 0. ]