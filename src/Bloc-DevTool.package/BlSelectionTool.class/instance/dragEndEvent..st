as yet unclassified
dragEndEvent: anEvent
	endPosition := anEvent position.
	client removeChild: selectionRect.
	self buildSelection.