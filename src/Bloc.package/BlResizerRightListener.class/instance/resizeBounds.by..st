resizer
resizeBounds: aBlBounds by: aPoint
	aBlBounds extent: ((aBlBounds extent + (aPoint x @ 0)) max: self minimumExtent)