geometry
globalPositionWithin: aGeometryElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ aGeometryElement localPointToGlobal: (aGeometryElement parentPointToLocal: self position)