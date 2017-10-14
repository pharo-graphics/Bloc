private - matrix
postScaleX: aX Y: aY
	"Apply the scale AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be scaled by given scale factor"

	sx := sx * aX.
	shy := shy * aY.
	shx := shx * aX.
	sy := sy * aY.
	x := x * aX.
	y := y * aY.