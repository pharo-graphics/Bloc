invalidate
resetCommands
	
	self recycleCommandsAndClearList: pendingCommands.
	self recycleCommandsAndClearList: postponedCommands.
	existingCommandTypes clear