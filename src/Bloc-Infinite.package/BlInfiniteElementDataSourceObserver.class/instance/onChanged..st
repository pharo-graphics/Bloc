event handling
onChanged: anEvent
	self assertNotInLayoutOrScroll.
	
	infiniteElement dataSource hasStableIds
		ifTrue: [
			"TODO Determine what actually changed.
			It is possible to do, since data source has stable ids"
			infiniteElement state structureChanged: true.
			infiniteElement setDataSourceChangedAfterLayout ]
		ifFalse: [ 
			infiniteElement state structureChanged: true.
			infiniteElement setDataSourceChangedAfterLayout ].

	infiniteElement dataSourceManager hasPendingCommands
		ifFalse: [ infiniteElement requestLayout ]