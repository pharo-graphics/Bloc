as yet unclassified
preScaleX: aX Y: aY Z: aZ
	"Apply the scaling BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be scaled,
	then be transformed by the original transform"
	
	sx := sx * aX.
	shy0 := shy0 * aX.
	shz0 := shz0 * aX.
	wx := wx * aX.
	
	shx0 := shx0 * aY.
	sy := sy * aY.
	shz1 := shz1 * aY.
	wy := wy * aY.
	
	shz1 := shz1 * aZ.
	shy1 := shy1 * aZ.
	sz := sz * aZ.
	wz := wz * aZ