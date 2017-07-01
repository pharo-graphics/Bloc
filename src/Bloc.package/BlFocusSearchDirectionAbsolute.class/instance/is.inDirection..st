testing
is: aDestinationBlBounds inDirection: aSourceBlBounds
	"Return true if aDestinationBlBounds is located in direction of a provided source bounds
	according to my destination type, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility