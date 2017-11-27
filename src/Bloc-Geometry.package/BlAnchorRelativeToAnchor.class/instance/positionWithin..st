geometry
positionWithin: aGeometryElement
	"Return anchor position within a given geometry element in its parent bounds"
	<return: #Point>

	^ aGeometryElement globalPointToParent: (self globalPositionFor: aGeometryElement)