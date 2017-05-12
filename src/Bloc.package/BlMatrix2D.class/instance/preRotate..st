matrix - transformations
preRotate: anAngle
	"Apply the rotation by the given angle in radians BEFORE my existing transformation.
	Any vector that is multiplied by the resulting matrix will first be rotated,
	then be transformed by the original transform"
	
	self preMultiplyBy: (self class rotation: anAngle)