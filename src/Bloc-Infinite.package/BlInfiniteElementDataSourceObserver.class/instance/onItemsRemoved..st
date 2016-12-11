event handling
onItemsRemoved: anEvent
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeRemoved: anEvent position
		itemCount: anEvent itemCount.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]