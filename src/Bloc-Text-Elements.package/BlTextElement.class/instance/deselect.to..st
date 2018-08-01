selection - management
deselect: aFromIndex to: aToIndex

	self selection
		deselect: aFromIndex
		to: aToIndex.

	self invalidate