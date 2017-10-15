matrix - transformations
scaleBy: aBlVector
	| aScale3D |
	"Apply a scaling defined by a given vector"
	
	aScale3D := aBlVector asScale3D.

	self
		assert: [ aScale3D z closeTo: 1 ]
		description: [ '2D Matrix is incompatible with 3D transformation' ].
		
	"Apply the scale AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be scaled by given scale factor"

	sx := sx * aScale3D x.
	shy := shy * aScale3D y.
	shx := shx * aScale3D x.
	sy := sy * aScale3D y.
	x := x * aScale3D x.
	y := y * aScale3D y