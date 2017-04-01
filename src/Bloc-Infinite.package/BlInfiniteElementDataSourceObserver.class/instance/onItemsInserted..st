event handling
onItemsInserted: anEvent
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeInserted: anEvent position
		itemCount: anEvent itemCount.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]