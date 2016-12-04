testing
hasStableIds
	"Returns true if this data source publishes a unique value that can
	act as a key for the item at a given position in the data set. If that item is relocated
	in the data set, the ID returned for that item should be the same"
	<return: #Number>

	^ hasStableIds