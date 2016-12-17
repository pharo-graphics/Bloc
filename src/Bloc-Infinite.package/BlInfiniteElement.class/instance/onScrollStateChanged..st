hooks - scrolling
onScrollStateChanged: aScrollingState
	"Called when the scroll state of InfiniteElement changes.
	Subclasses should use this method to respond to state changes instead of an explicit listener.
	This method will always be invoked before firing events, but after the Layout responds to the scroll state change"