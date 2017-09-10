geometry
positionWithin: aGeometryElement
	"Return an attach point element position within a given geometry element in its local bounds"
	<return: #Point>

	^ aGeometryElement globalPointToParent: self globalPosition