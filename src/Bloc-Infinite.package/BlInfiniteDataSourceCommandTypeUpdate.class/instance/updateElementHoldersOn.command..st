dispatch
updateElementHoldersOn: aContext command: aCommand
	aContext controller
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		payload: aCommand payload