event processing
subprocessDragEvent: anEvent
	(self canBeDragEvent: anEvent)
		ifFalse: [ ^ self ].
	currentDragTarget
		ifNil: [ currentDragTarget := lastMouseDownEvent target.
			lastOverTarget := nil.
			dragStartMask := isMouseStillDown.
			self fireAsDragStartEvent: anEvent.
			self preProcess: anEvent ]
		ifNotNil: [ self fireAsDragEvent: anEvent.
						self updateDragView ].
	