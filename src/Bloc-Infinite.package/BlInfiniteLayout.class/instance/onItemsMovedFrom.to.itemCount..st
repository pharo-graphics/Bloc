items - hooks
onItemsMovedFrom: fromPosition to: toPosition itemCount: count
	"Sent when an item is moved withing the datasource.
	Note that, an item may also change position in response to another ADD/REMOVE/MOVE operation.
	I am only sent if and only if BlInfiniteDataSource>>#notifyItemMoved is sent"