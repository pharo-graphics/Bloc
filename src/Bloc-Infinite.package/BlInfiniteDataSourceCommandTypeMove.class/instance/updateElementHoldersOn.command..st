dispatch
updateElementHoldersOn: aContext command: aCommand
	aContext controller
		offsetPositions: aCommand startPosition
		forMove: aCommand itemCount