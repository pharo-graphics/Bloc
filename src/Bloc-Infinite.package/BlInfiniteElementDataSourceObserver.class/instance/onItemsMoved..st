event handling
onItemsMoved: anEvent
	| needsUpdate |
	self assertNotInLayoutOrScroll.
	
	needsUpdate := infiniteElement dataSourceManager
		onItemRangeMoved: anEvent from
		to: anEvent to
		itemCount: 1.

	needsUpdate
		ifTrue: [ self triggerUpdateProcessor ]