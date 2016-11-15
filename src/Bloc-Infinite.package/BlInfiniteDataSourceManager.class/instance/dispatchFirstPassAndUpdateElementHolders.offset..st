helper
dispatchFirstPassAndUpdateElementHolders: aCommand offset: offsetStart

	self controller onDispatchFirstPass: aCommand.
	aCommand updateElementHoldersOn: self offset: offsetStart