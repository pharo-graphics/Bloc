geometry
minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ (((aSourceBlBounds top + aSourceBlBounds height) / 2.0)
		- ((aDestinationBlBounds top + aDestinationBlBounds height) / 2.0)) abs