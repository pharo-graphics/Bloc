matrix - transformations
preTranslateX: aX Y: aY
	"Apply the translation BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be translated,
	then be transformed by the original transform"

	x := shx + (sx * aX) + (shx * aY).
	y := y + (shy * aX) + (sy * aY)