*Bloc-SVG
visualBoundsInParent
	|bounds|
	bounds := BlBounds fromRectangle: (self visualBoundsOn: (Bloc preferableSpartaCanvas offscreen)).
	transform transformBounds: bounds.
	bounds translateBy: self position.
	^bounds asRectangle