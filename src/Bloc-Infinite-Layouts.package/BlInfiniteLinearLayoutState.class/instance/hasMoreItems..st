testing
hasMoreItems: anInfiniteState
	"Return true if there are more items in the data source"
	<return: #Boolean>
	
	^ currentPosition between: 1 and: anInfiniteState itemCount