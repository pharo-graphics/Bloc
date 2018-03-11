resizer
resizeBounds: aBlBounds by: aPoint
	aBlBounds extent: ((aBlBounds extent + (0 @ aPoint y)) max: self minimumExtent)