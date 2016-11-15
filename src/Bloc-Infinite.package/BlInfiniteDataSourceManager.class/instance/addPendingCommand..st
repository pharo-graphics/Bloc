commands adding
addPendingCommand: aCommand
	"Adds new command to pending list.
	aCommand must not be nil"
	self assert: aCommand isNotNil.
	
	pendingCommands add: aCommand