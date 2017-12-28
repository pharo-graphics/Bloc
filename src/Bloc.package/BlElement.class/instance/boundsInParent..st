geometry bounds
boundsInParent: aBounds
	<return: #BlBounds>
	
	self deprecated: 'Use `element bounds inParent` instead'.
	
	^ self localBoundsToParent: (self boundsInLocal: aBounds)