event firing
fireAsDragStartEvent: anEvent
	self	fireEvent:
			(anEvent asDragStartEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space newDragboard;
				yourself)