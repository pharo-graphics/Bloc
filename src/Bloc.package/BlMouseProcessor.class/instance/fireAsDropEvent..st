event firing
fireAsDropEvent: anEvent

	self	fireEvent:
			(anEvent asDropEvent
				gestureSource: currentDragTarget;
				gestureTarget: anEvent target;
				startButtons: dragStartMask;
				dragboard: self space dragboard;
				yourself)