*Bloc-SVG
visualBoundsInParent
	| theBounds |
	theBounds := BlBounds fromRectangle: self visualBounds.
	transformation transformBounds: theBounds.
	theBounds translateBy: self position.
	^ theBounds asRectangle