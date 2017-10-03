*Bloc-SVG
visualBoundsInParent
	| theBounds |
	theBounds := BlBounds fromRectangle: (self visualBoundsOn: (Bloc preferableSpartaCanvas offscreen)).
	transform transformBounds: theBounds.
	theBounds translateBy: self position.
	^ theBounds asRectangle