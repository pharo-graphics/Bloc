resizer
resizeBounds: aBlBounds by: aPoint
	aBlBounds extent: ((aBlBounds extent + aPoint) max: self minimumExtent)