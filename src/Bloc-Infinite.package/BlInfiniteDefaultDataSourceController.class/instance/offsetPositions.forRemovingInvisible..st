manager -> element
offsetPositions: aStartPosition forRemovingInvisible: anItemCount
	| newDeletedCount |
	element
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	element markItemsAddedOrRemoved.
	newDeletedCount := element state deletedInvisibleItemCountSincePreviousLayout + anItemCount.
	element state deletedInvisibleItemCountSincePreviousLayout: newDeletedCount