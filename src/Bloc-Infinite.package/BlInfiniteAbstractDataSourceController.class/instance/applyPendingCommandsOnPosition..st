element -> manager
applyPendingCommandsOnPosition: aPosition
	"Ask data source manager to apply all pending commands
	on provided position (transform it) and return result.
	aPosition must not be nil"
	<return: #Number>

	^ self subclassResponsibility