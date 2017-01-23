transformations
preTranslateX: aX Y: aY
	"Apply the translation BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be translated,
	then be transformed by the original transform"

	a31 := a21 + (a11 * aX) + (a21 * aY).
	a32 := a32 + (a12 * aX) + (a22 * aY)