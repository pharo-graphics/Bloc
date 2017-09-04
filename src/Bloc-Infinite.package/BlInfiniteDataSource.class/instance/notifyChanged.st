event firing
notifyChanged
	"Notify any registered event handlers that the data set has changed.
	There are two different classes of data change events, item changes and structural
	changes. Item changes are when a single item has its data updated but no positional
	changes have occurred. Structural changes are when items are inserted, removed or moved
	within the data set.
	This event does not specify what about the data set has changed, forcing
	any observers to assume that all existing items and structure may no longer be valid.
	InfiniteLayout will be forced to fully rebind and relayout all visible elements."

	self notifyWithEvent: (BlInfiniteDataSourceChanged new
		dataSource: self;
		yourself)