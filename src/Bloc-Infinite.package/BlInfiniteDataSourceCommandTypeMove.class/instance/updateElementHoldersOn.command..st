dispatch
updateElementHoldersOn: aContext command: aCommand
	aContext controller
		offsetPositionsForMove: aCommand startPosition
		to: aCommand itemCount