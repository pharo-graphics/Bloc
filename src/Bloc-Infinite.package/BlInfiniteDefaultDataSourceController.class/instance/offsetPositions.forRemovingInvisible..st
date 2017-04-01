manager -> element
offsetPositions: aStartPosition forRemovingInvisible: anItemCount
	| newDeletedCount |

	infiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	infiniteElement markItemsAddedOrRemoved.

	newDeletedCount := infiniteElement state deletedInvisibleItemCountSincePreviousLayout + anItemCount.
	infiniteElement state deletedInvisibleItemCountSincePreviousLayout: newDeletedCount