api - scrolling notifying
notifyScrolled: aPoint
	"Notify all event handlers that InfiniteElemnet scrolled by a delta point"

	self fireEvent: (BlInfiniteScrolledEvent delta: aPoint)