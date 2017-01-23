geometry bounds
transformedBounds: aSpartaRectangle

	^ transform transformBounds: (self boundsInLocal: aSpartaRectangle)