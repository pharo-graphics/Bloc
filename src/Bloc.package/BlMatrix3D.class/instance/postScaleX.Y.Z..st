matrix - transformations
postScaleX: aX Y: aY Z: aZ
	"Apply the scale AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be scaled by given scale factor"

	sx := sx * aX.
	shx0 := shx0 * aX.
	shx1 := shx1 * aX.
	x := x * aX.

	shy0 := shy0 * aY.
	sy := sy * aY.
	shy1 := shy1 * aY.
	y := y * aY.

	shz0 := shz0 * aZ.
	shz1 := shz1 * aZ.
	sz := sz * aZ.
	z := z * aZ