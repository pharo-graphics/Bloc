private
addHolderToRecyclerPool: anElementHolder

	self dispatchHolderRecycled: anElementHolder.
	anElementHolder detachInfiniteElement.
	self pool put: anElementHolder