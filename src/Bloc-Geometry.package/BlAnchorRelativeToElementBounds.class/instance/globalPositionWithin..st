geometry
globalPositionWithin: aGeometryElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self positionWithinBounds: self referenceElement bounds inSpace