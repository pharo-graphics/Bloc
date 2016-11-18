element -> manager
onItemRangeChanged: aStartPosition itemCount: anItemCount payload: aPayloadObject
	"Ask data source manager to enqueue a corresponding command that items were changed.
	Return true if commands should be processed, false otherwise.
	startPosition must not be nil.
	itemCount must not be nil.
	anObject is optional and may be nil"
	<return: #Boolean>
	
	^ self subclassResponsibility