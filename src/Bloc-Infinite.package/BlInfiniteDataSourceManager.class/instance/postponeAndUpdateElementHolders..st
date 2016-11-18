private
postponeAndUpdateElementHolders: aCommand
	
	postponedCommands add: aCommand.
	aCommand updateElementHoldersOn: self