bounds
inverseTransformBounds: aBounds
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>

	^ self matrix inverted transformBounds: aBounds