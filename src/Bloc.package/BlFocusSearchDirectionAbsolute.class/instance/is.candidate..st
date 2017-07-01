testing
is: aDestinationBlBounds candidate: aSourceBlBounds
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility