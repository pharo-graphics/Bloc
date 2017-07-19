event handling
onItemsChanged: anEvent
	| needsUpdate |
	self assertNotInLayoutOrScroll.

	needsUpdate := infiniteElement dataSourceManager
		onItemRangeChanged: anEvent position
		itemCount: anEvent itemCount
		payload: nil.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]