mouse drag
processDragEnd: aMouseUpEvent

	self
		assert: [ self isDragging ]
		description: [ 'Can not process mouse up event as drag end if I am not in dragging state' ].
		
	self
		assert: [ currentDragTarget isNotNil ]
		description: [ 'When we drag something it can not be nil' ].

	aMouseUpEvent primaryButtonPressed
		ifTrue: [ 
			self fireAsDragEndEvent: aMouseUpEvent.
			self fireAsDropEvent: aMouseUpEvent.
						
			currentDragTarget := nil.
			dndInProgress := false.
			lastOverTarget := nil.
			dragStartMask := 0 ]