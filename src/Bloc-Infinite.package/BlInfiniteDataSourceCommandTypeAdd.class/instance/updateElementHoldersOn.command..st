dispatch
updateElementHoldersOn: aContext command: aCommand
	aContext controller
		offsetPositions: aCommand positionStart
		forAdd: aCommand itemCount