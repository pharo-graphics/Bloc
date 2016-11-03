as yet unclassified
dragStartEvent: anEvent
	self resetCurrentSelections.
	startPosition := anEvent position.
	selectionRect extent:50@50; position:startPosition.
	client addChild: selectionRect 