geometry bounds
boundsInParent: aBounds
	<return: #BlBounds>

	^ self localBoundsToParent: (self boundsInLocal: aBounds)