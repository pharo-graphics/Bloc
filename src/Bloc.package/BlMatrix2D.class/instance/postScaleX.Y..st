transformations
postScaleX: aX Y: aY
	"Apply the scale AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be scaled by given scale factor"

	a11 := a11 * aX.
	a12 := a12 * aY.
	a21 := a21 * aX.
	a22 := a22 * aY.
	a31 := a21 * aX.
	a32 := a22 * aY.