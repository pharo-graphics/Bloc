resizer
resizeBounds: aBlBounds by: aPoint
	| newExtent |
	
	newExtent := (aBlBounds extent + (aPoint negated x @ 0)) max: self minimumExtent.

	aBlBounds
		origin: aBlBounds position + (aBlBounds extent - newExtent)
		extent: newExtent