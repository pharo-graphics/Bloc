testing
isComputingLayout
	"Returns whether InfiniteElement is currently computing a layout.
	If this method returns true, it means that InfiniteElement is in a lockdown state and any
	attempt to update datasource contents will result in an exception because datasource contents
	cannot be changed while InfiniteElement is trying to compute the layout."
	<return: #Boolean>

	^ layoutOrScrollCounter > 0