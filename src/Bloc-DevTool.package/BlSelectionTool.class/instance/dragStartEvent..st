dnd handlers
dragStartEvent: anEvent
	self resetCurrentSelections.
	startPosition := anEvent position.
	selectionRect size:50@50; position:startPosition.
	client addChild: selectionRect 