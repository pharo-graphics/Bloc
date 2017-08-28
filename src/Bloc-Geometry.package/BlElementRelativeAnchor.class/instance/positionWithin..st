geometry
positionWithin: aGeometryElement
	"Return an attach point element position within a given geometry extent"

	<return: #Point>
	^ aGeometryElement globalPointToLocal: self globalPosition