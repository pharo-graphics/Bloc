instance creation
exact: anExtent
	"Return an instance of exact geometry resizer for a given extent as a point.
	anExtent must not be nil"
	<return: #BlGeomResizer>
	
	^ BlGeomExactResizer extent: anExtent