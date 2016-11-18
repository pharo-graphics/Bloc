element -> manager
onItemRangeRemoved: aStartPosition itemCount: itemCount
	"Ask data source manager to enqueue a corresponding command that items were deleted.
	Return true if commands should be processed, false otherwise.
	startPosition must not be nil.
	itemCount must not be nil."
	<return: #Boolean>

	^ self subclassResponsibility