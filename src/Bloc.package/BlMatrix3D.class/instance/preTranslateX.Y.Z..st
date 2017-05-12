matrix - transformations
preTranslateX: aX Y: aY Z: aZ
	"Apply the translation BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be translated,
	then be transformed by the original transform"
	
	x := x + (aX * sx) + (aY * shx0) + (aZ * shx1).
	y := y + (aX * shy0) + (aY * sy) + (aZ * shy1).
	z := z + (aX * shz0) + (aY * shz1) + (aZ * sz).
	w := w + (aX * wx) + (aY * wy) + (aZ * wz)