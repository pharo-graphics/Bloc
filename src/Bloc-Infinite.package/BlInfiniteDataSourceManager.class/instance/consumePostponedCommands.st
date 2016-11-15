commands processing
consumePostponedCommands
	
	postponedCommands do: [ :command |
		self controller onDispatchSecondPass: command ].
	
	self recycleCommandsAndClearList: postponedCommands