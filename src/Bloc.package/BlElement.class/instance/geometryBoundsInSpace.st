geometry bounds
geometryBoundsInSpace
	"Return bounds of my geometry in space coordinates.
	Note, that geometry bounds may differ from #boundsInSpace for the case of non-trivial geometry.
	Geometry bounds in space is used to find out if a mouse event position is within the element.
	GEOMETRY BOUNDS PROPERTY DOES NOT TAKE EFFECT OR BORDER OR BACKGROUND INTO ACCOUNT"
	<return: #Rectangle>

	^ boundsCache geometryBoundsInSpace