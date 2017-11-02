selection - management
selectSet: aFromIndex to: aToIndex

	self selection
		removeAll;
		select: aFromIndex
		to: aToIndex.

	self invalidate