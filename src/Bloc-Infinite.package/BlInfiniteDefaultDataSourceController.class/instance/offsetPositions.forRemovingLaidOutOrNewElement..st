manager -> element
offsetPositions: aStartPosition forRemovingLaidOutOrNewElement: anItemCount
	element
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	element markItemsAddedOrRemoved