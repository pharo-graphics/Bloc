geometry
globalPositionWithin: aGeometryElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self referenceElement boundsInSpace bottomLeft