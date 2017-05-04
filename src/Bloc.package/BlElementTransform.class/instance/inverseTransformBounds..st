transformation
inverseTransformBounds: aBounds
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"

	<return: #BlBounds>
	self ensure2D.
	matrix2D inverted transformBounds: aBounds.
	^ aBounds