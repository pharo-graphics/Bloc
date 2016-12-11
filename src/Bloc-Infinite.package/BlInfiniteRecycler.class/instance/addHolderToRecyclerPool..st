private
addHolderToRecyclerPool: anElementHolder

	self dispatchElementRecycled: anElementHolder.
	anElementHolder detachInfiniteElement.
	self pool put: anElementHolder