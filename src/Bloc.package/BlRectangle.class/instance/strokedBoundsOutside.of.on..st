visual bounds
strokedBoundsOutside: aBlBounds of: aBlElement on: aCanvas 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width