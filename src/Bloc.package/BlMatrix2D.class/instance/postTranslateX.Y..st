transformations
postTranslateX: aX Y: aY
	"Apply the translation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be translated by given translation"

	a31 := a31 + aX.
	a32 := a32 + aY