transformations
postRotate: anAngle
	"Apply the rotation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be rotated by given angle in radians"

	self postMultiplyBy: (self class rotation: anAngle)