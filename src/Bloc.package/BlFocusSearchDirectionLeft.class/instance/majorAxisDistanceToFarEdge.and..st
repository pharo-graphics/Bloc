geometry
majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds"
	<return: #Number>
	
	^ aSourceBlBounds left - aDestinationBlBounds left