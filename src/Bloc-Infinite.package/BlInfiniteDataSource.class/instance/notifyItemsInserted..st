event firing
notifyItemsInserted: anInterval
	"Notify any registered observers that the currently reflected ===anInterval size===
	items starting at ===anInterval first=== have been newly inserted. The items
	previously located at ===anInterval first=== and beyond can now be found starting
	at position ===anInterval last===.
	This is a structural change event. Representations of other existing items in the
	data set are still considered up to date and will not be rebound, though their positions
	may be altered"

	self fireEvent: (BlInfiniteDataSourceItemRangeInserted
		position: anInterval first
		itemCount: anInterval size)