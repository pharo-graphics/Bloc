element -> manager
onItemRangeMoved: fromPosition toPosition: toPosition itemCount: itemCount

	fromPosition = toPosition
		ifTrue: [ ^ false ].
	
	itemCount > 1
		ifTrue: [ Error signal: 'Moving more than one item is not supported yet :(' ].
	
	self dataSourceManager addPendingCommand: (self createMoveCommand: fromPosition itemCount: toPosition).
	^ self dataSourceManager pendingCommandsCount = 1