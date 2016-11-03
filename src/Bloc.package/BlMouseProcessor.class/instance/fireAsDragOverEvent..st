event firing
fireAsDragOverEvent: anEvent
	self	fireEvent:
			(anEvent asDragOverEvent
				startButtons: dragStartMask;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)