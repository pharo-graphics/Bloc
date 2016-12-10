recycler -> data source
createElementHolderOfType: anItemType
	<return: #BlInfiniteElementHolder>

	^ self dataSource createHolder: infiniteElement type: anItemType