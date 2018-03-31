recycler -> data source
createElementHolderOfType: anItemType
	<return: #BlInfiniteHolder>

	^ self dataSource createHolder: infiniteElement type: anItemType