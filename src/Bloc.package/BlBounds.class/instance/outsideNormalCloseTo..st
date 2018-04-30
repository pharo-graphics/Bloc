vector functions
outsideNormalCloseTo: aPoint
	<return: #BlRay>
	| anEdge aProjection aNormal |
	
	anEdge := self closestEdgeTo: aPoint.
	aProjection := anEdge projection: aPoint.
	aNormal := anEdge vector normal.

	^ BlRay from: aProjection directed: aNormal