dispatch
updateElementHoldersOn: aContext command: aCommand
	aContext controller
		offsetPositions: aCommand startPosition
		forRemovingLaidOutOrNewElement: aCommand itemCount