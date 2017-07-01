geometry
majorAxisDistanceToFarEdgeNormalized: aDestinationBlBounds and: aSourceBlBounds
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds
	or 1 if destination is not in the direction of a source.
	Note: we return 1 in order to prevent conflicts with #majorAxisDistanceNormalized:and:"
	<return: #Number>
	
	^ 1 max: (self majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds)