layout - notifying
notifyAvailableSpaceChanged: aNumber
	self announcer announce: (BlInfiniteLinearLayoutAvailableSpaceChanged new availableSpace: aNumber)