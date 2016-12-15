interpolation
interpolate: aNumber
	| t |
	t := aNumber - 1.0.
	^ (t * t * t * t * t) + 1.0