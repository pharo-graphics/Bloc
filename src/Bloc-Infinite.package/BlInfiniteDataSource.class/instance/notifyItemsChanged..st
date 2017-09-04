event firing
notifyItemsChanged: anInterval
	"Notify any registered event handlers that the itemCount items starting at aPosition have changed.
	This is an item change event, not a structural change event. It indicates that
	any reflection of the data in the given position range is out of date and should
	be updated. The items in the given range retain the same identity"
	
	self notifyWithEvent: (BlInfiniteDataSourceItemRangeChanged
		position: anInterval first
		itemCount: anInterval size)