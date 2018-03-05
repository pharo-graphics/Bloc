layout - notifying
notifyChunkAdded: anElement
	self announcer announce: (BlInfiniteLinearLayoutChunkAdded new element: anElement)