testing
hasCommands
	"Return trye if there are both pending and postponed commands,
	otherwise false"
	<return: #Boolean>

	^ self hasPendingCommands and: [ self hasPostponedCommands ]