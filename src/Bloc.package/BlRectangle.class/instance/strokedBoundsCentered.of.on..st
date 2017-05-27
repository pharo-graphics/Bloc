visual bounds
strokedBoundsCentered: aBlBounds of: aBlElement on: aCanvas 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width / 2.0