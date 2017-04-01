event handling
onChanged: anEvent
	self assertNotInLayoutOrScroll.
	
	infiniteElement state structureChanged: true.
	infiniteElement setDataSourceChangedAfterLayout.

	infiniteElement dataSourceManager hasPendingCommands
		ifFalse: [ infiniteElement requestLayout ]