notifying
notifyItemMoved: aFromPosition to: aToPosition
	"Notify any registered event handlers that the item reflected at aFromPosition
	has been moved to aToPosition.
	This is a structural change event. Representations of other existing items in the
	data set are still considered up to date and will not be rebound, though their
	positions may be altered"

	self fireEvent: (BlInfiniteDataSourceItemRangeMoved
		from: aFromPosition
		to: aToPosition)