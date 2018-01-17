dnd handlers
dragEndEvent: anEvent
	anEvent currentTarget space dispatchEvent: (BlSpaceDragCancelEvent new delegate: delegate; position: anEvent position)