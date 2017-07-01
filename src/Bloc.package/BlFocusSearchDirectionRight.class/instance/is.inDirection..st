testing
is: aDestinationBlBounds inDirection: aSourceBlBounds
	"In case of right direction destination bounds must be located to right from source"
	<return: #Boolean>

	^ aSourceBlBounds right <= aDestinationBlBounds left