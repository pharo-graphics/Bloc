initialization
initialize
	super initialize.
	
	postponedCommands := OrderedCollection new.
	pendingCommands := OrderedCollection new.
	commandsPool := self defaultCommandsPool.
	shouldRecycle := self defaultShouldRecycle.
	commandsReorderer := self defaultCommandsReorderer dataSourceManager: self.
	existingCommandTypes := BlInfiniteDataSourceCommandTypeFlags new