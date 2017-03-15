accessing
attachPoint: aBlAttachPoint
	attachPoint := aBlAttachPoint.
	attachPoint
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
		do: [ :anEvent | self dispatchMoveEvent ]