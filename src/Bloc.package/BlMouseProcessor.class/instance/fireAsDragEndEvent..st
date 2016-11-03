event firing
fireAsDragEndEvent: anEvent

	self fireEvent:
			(anEvent asDragEndEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)