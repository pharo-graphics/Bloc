resizer
resizeBounds: aBlBounds by: aPoint
	| newExtent |
	
	newExtent := (aBlBounds extent + (aPoint x negated @ aPoint y)) max: self minimumExtent.

	aBlBounds
		origin: (aBlBounds position x + (aBlBounds extent - newExtent) x) @ aBlBounds position y
		extent: newExtent