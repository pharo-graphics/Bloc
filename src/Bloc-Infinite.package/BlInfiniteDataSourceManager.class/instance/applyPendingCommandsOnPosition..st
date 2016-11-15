commands processing
applyPendingCommandsOnPosition: aPosition
	| position |
	position := aPosition.
	
	pendingCommands do: [ :command |
		position := command applyOnPosition: position ].
	
	^ position