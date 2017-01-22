transformations
preScaleX: aX Y: aY
	"Apply the scaling BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be scaled,
	then be transformed by the original transform"

	a11 := a11 * aX.
	a12 := a12 * aX.
	a21 := a21 * aY.
	a22 := a22 * aY