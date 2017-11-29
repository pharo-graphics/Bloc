instance creation
exact: anExtent
	"Return an instance of exact background resizer for a given extent as a point.
	anExtent must not be nil"
	<return: #BlBackgroundResizer>
	
	^ BlBackgroundExactResizer extent: anExtent