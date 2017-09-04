event firing
notifyItemsRemoved: anInterval
	"Notify any registered event handlers that the ===anInterval size=== items previously
	located at ===anInterval first=== have been removed from the data set. The items
	previously located at and after ===anInterval last=== may now be found ===oldPosition - anInterval size===.
	This is a structural change event. Representations of other existing items in the data
	set are still considered up to date and will not be rebound, though their positions
 	may be altered."

	self notifyWithEvent: (BlInfiniteDataSourceItemRangeRemoved
		position: anInterval first
		itemCount: anInterval size)