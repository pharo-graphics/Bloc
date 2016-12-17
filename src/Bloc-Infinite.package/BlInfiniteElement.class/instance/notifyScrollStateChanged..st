notifying
notifyScrollStateChanged: aScrollState
	"Notify all event handlers that scroll state of InfiniteElement has been changed"

	self fireEvent: (BlInfiniteScrollChangedEvent scrollState: aScrollState)