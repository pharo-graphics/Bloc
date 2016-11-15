element -> manager
onItemRangeChanged: startPosition itemCount: itemCount payload: anObject

	self dataSourceManager addPendingCommand: (self createUpdateCommand: startPosition itemCount: itemCount payload: anObject).
	^ self dataSourceManager pendingCommandsCount = 1