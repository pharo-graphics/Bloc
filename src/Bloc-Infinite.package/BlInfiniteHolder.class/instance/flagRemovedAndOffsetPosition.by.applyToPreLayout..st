private
flagRemovedAndOffsetPosition: aNewPosition by: anOffset applyToPreLayout: applyToPreLayout

	self flags addRemoved.
	self offsetPositionBy: anOffset applyToPreLayout: applyToPreLayout.
	position := aNewPosition