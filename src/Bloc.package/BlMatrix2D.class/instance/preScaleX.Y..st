matrix - transformations
preScaleX: aX Y: aY
	"Apply the scaling BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be scaled,
	then be transformed by the original transform"

	sx := sx * aX.
	shy := shy * aX.
	shx := shx * aY.
	sy := sy * aY