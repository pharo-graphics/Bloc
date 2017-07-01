testing
is: aDestinationBlBounds inDirection: aSourceBlBounds
	"In case of down direction destination bounds must be located below the source"
	<return: #Boolean>

	^ aSourceBlBounds bottom <= aDestinationBlBounds top