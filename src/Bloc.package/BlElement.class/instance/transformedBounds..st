geometry bounds
transformedBounds: aSpartaRectangle
	^ transform transformRectangle: (self boundsInLocal: aSpartaRectangle)