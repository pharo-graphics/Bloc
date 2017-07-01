geometry
majorAxisDistanceNormalized: aDestinationBlBounds and: aSourceBlBounds
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds
	or 0 if destination is not in the direction of a source"
	<return: #Number>
	
	^ 0 max: (self majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds)