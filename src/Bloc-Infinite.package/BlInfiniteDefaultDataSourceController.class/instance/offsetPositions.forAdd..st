manager -> element
offsetPositions: aStartPosition forAdd: anItemCount
	
	infiniteElement
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.
		
	infiniteElement markItemsAddedOrRemoved