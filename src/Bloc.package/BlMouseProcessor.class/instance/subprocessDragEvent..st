event processing
subprocessDragEvent: anEvent
	(self canStartDrag: anEvent)
		ifFalse: [ ^ self ].

	currentDragTarget
		ifNil: [ currentDragTarget := previousMouseDownEvent target.
			lastOverTarget := nil.
			dragStartMask := isMouseStillDown.
			self fireAsDragStartEvent: anEvent.
			self preProcess: anEvent ]
		ifNotNil: [ self fireAsDragEvent: anEvent.
						self updateDragView ].
	