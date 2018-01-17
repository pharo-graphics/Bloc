mouse up
processDragEnd: aMouseUpEvent

	self
		assert: [ self isDragging ]
		description: [ 'Can not process mouse up event as drag end if I am not in dragging state' ].

	

	(currentDragTarget isNotNil and: [ (isMouseStillDown bitAnd: dragStartMask) ~= dragStartMask ])
		ifTrue: [ 
			
			self fireAsDragEndEvent: aMouseUpEvent.
			self fireAsDropEvent: aMouseUpEvent.
			self space deleteDragboard.
			currentDragTarget := nil.
			lastOverTarget := nil.
			dragStartMask := 0. ]