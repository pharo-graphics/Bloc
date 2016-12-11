recycler -> element
onElementHolderRecycled: anElementHolder

	self dataSource onElementRecycled: anElementHolder.
	self infoStore removeHolder: anElementHolder