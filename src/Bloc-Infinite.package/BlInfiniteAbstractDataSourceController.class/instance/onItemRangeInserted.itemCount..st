element -> manager
onItemRangeInserted: startPosition itemCount: itemCount
	"Ask data source manager to enqueue a corresponding command that items were inserted.
	Return true if commands should be processed, false otherwise.
	startPosition must not be nil.
	itemCount must not be nil."
	<return: #Boolean>
	
	^ self subclassResponsibility