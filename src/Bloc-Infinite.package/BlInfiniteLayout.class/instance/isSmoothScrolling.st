scrolling - testing
isSmoothScrolling
	"Return true if InfiniteElement is currently in the state of smooth scrolling,
	false otherwise"
	<return: #Boolean>

	^ smoothScroller isNotNil and: [ smoothScroller isRunning ]