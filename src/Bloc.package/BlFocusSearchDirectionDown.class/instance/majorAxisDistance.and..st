geometry
majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ aDestinationBlBounds top - aSourceBlBounds bottom