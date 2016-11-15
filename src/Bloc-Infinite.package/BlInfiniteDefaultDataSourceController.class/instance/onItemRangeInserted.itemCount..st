element -> manager
onItemRangeInserted: startPosition itemCount: itemCount
	
	self dataSourceManager addPendingCommand: (self createAddCommand: startPosition itemCount: itemCount).
	^ self dataSourceManager pendingCommandsCount = 1