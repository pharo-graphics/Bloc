element -> manager
consumeCommandsInOnePass
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume postponed updates (if there is) in case there was a pre-process call
	w/o a matching consumePostponedUpdates."
	self consumePostponedCommands.

	pendingCommands do: [ :command |
		self controller onDispatchSecondPass: command.
		command applyOn: self.
		self onCommandProcessed: command ].

	self recycleCommandsAndClearList: pendingCommands.
	existingCommandTypes clear