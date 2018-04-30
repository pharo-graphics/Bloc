vector functions
closestEdgeTo: aPoint
	<return: #BlRay>

	^ self counterClockwiseEdges detectMin: [ :aRay | aRay distanceTo: aPoint ]