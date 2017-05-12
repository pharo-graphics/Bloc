matrix - transformations
postTranslateX: aX Y: aY Z: aZ
	"Apply the translation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be translated by given translation"

	sx := sx + (wx * aX).
	shx0 := shx0 + (wy * aX).
	shx1 := shx1 + (wz * aX).
	x := x + (w * aX).

	shy0 := shy0 + (wx * aY).
	sy := sy + (wy * aY).
	shy1 := shy1 + (wz * aY).
	y := y + (w * aY).

	shz0 := shz0 + (wx * aZ).
	shz1 := shz1 + (wy * aZ).
	sz := sz + (wz * aZ).
	z := z + (w * aZ)