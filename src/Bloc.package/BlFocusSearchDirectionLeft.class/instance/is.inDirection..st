testing
is: aDestinationBlBounds inDirection: aSourceBlBounds
	"In case of left direction destination bounds must be located to left from source"
	<return: #Boolean>

	^ aSourceBlBounds left >= aDestinationBlBounds right