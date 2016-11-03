event testing
isValidDragTarget: aEvent
	^ (aEvent target = self space root) not