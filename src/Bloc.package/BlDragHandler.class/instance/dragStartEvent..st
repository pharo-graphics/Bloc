dnd handlers
dragStartEvent: anEvent
	anEvent consumed: true.

	delegate items: { BlDragItem new sourceElement: anEvent currentTarget }.

	anEvent currentTarget space dispatchEvent: (BlSpaceDragLiftEvent new delegate: delegate; position: anEvent position)