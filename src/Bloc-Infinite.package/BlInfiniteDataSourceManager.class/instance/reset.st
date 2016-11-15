invalidate
reset
	
	self recycleCommandsAndClearList: pendingCommands.
	self recycleCommandsAndClearList: postponedCommands.