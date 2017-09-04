event firing
notifyItemsChanged: anInterval payload: anObject
	"Notify any registered event handlers that the itemCount items starting at aPosition have changed.
	This is an item change event, not a structural change event. It indicates that
	any reflection of the data in the given position range is out of date and should
	be updated. The items in the given range retain the same identity.
	
	By using this update method users have to pass a payload object (any) for partial change.
	All payloads will be merged and then passed to #onBindHolder:at:payloads:"

	self
		assert: [ anObject isNotNil ]
		description: [ 'Payload must not be nil! For full update use #notifyItemsChanged:' ].
		
	self notifyWithEvent: (BlInfiniteDataSourceItemRangeChanged
		position: anInterval first
		itemCount: anInterval size
		payload: anObject)