commands processing
consumeCommandsInOnePass
	
	self consumePostponedCommands.
	
	pendingCommands do: [ :command |
		self controller onDispatchSecondPass: command.
		command applyOn: self.
		self onCommandProcessed: command ].
	
	self recycleCommandsAndClearList: pendingCommands