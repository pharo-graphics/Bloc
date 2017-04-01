manager -> element
offsetPositions: aStartPosition forRemovingLaidOutOrNewElement: anItemCount

	infiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	infiniteElement markItemsAddedOrRemoved