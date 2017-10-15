matrix - transforming points
transformPoint: aPoint
	"Transform a given point according to transformation matrix.
	I perform a double dispatch to handle 2D/3D/4D points and 2D/3D matrices"
	<return: #BlPoint>

	^ aPoint transformedOn: self