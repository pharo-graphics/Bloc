private - matrix
postTranslateX: aX Y: aY
	"Apply the translation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be translated by given translation"

	x := x + aX.
	y := y + aY