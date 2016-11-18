element -> manager
applyPendingCommandsOnPosition: aPosition
	"Virually perform every pending command to determine how provided
	position will change.
	Return new position if all commands would be actually performed"
	<return: #Number>
	| position |

	position := aPosition.
	
	pendingCommands do: [ :command |
		position := command applyOnPosition: position ].
	
	^ position