event firing
fireAsDragStartEvent: anEvent
	^ self fireEvent:
			(anEvent asDragStartEvent
				startButtons: dragStartMask;
				target: anEvent target;
				gestureSource: anEvent target;
				dragboard: self space newDragboard;
				yourself)