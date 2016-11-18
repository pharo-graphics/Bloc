testing
isHidden: aChildElement
	"Returns whether a child is visible to InfiniteLayout or not"
	<return: #Boolean>

	^ hiddenChildren includes: aChildElement