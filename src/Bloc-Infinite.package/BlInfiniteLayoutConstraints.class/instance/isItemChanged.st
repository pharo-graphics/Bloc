testing
isItemChanged
	"Returns true if the datasource item corresponding to the element I am attached to has been changed in the data set.
	An InfiniteElement may choose to treat it differently in order to animate its changing state."
	<return: #Boolean>

	^ holder isChanged