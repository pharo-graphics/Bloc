element -> manager
onItemRangeRemoved: startPosition itemCount: itemCount

	self dataSourceManager addPendingCommand: (self createRemoveCommand: startPosition itemCount: itemCount).
	^ self dataSourceManager pendingCommandsCount = 1