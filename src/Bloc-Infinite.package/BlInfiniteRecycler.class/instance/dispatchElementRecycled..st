event dispatching
dispatchElementRecycled: anElementHolder

	self notifyElementRecycled: anElementHolder.
	self controller onElementHolderRecycled: anElementHolder