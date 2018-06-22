iterator - testing
isLineFeed: anItem
	"Return true of given item represents a line feed, false otherwise"
	<return: #Boolean>

	^ anItem = Character lf