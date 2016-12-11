dispatch
updateElementHoldersOn: aContext command: aCommand
	aContext controller
		offsetPositions: aCommand positionStart
		forRemovingLaidOutOrNewElement: aCommand itemCount