geometry bounds
transformedBounds: aSpartaRectangle

	^ transformation transformBounds: (self boundsInLocal: aSpartaRectangle)