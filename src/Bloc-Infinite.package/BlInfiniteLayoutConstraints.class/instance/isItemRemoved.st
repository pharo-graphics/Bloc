testing
isItemRemoved
	"Returns true if the datasource item corresponding to the element I am attached to has been removed from the data set.
	An InfiniteLayout may choose to treat it differently in order to animate its outgoing or disappearing state"
	<return: #Boolean>

	^ holder isRemoved