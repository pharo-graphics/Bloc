dispatch
updateElementHoldersOn: aContext offset: offsetStart command: aCommand
	aContext controller
		markElementHoldersUpdated: offsetStart
		itemCount: aCommand itemCount
		payload: aCommand payload