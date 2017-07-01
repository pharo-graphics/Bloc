testing
is: aDestinationBlBounds inDirection: aSourceBlBounds
	"In case of up direction destination bounds must be located below the source"
	<return: #Boolean>

	^ aSourceBlBounds top >= aDestinationBlBounds bottom