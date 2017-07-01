testing
is: aDestinationBlBounds candidate: aSourceBlBounds
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise"
	<return: #Boolean>

	^ (aSourceBlBounds top < aDestinationBlBounds top
		or: [ aSourceBlBounds bottom <= aDestinationBlBounds top ])
			and: [ aSourceBlBounds bottom < aDestinationBlBounds bounds ]