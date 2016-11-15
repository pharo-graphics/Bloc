commands processing
preProcessCommands

	commandsReorderer reorderCommands: pendingCommands.
	pendingCommands do: [ :command |
		command applyOn: self.
		self onCommandProcessed: command ].
	pendingCommands removeAll