dispatch
updateElementHoldersOn: aContext command: aCommand
	aContext controller
		offsetPositionRecordsForMove: aCommand startPosition
		to: aCommand itemCount