*Bloc-SVG
visualBoundsInParent
	| theBounds |
	theBounds := BlBounds fromRectangle: (self visualBoundsOn: (Bloc preferableSpartaCanvas offscreen)).
	transformation transformBounds: theBounds.
	theBounds translateBy: self position.
	^ theBounds asRectangle