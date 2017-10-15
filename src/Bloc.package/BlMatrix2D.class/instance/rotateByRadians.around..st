matrix - transformations
rotateByRadians: anAngle around: aBlVector
	"Apply a rotation transformation by a given amount of radians around a provided axis vector"
	
	self
		assert: [ aBlVector = BlVector zAxis ]
		description: [ '2D Matrix is incompatible with 3D transformation' ].
		
	"Apply the rotation AFTER my existing transformation.
	Any vector that is multiplied by the resulting matrix
	will first be transformed by the original transform,
	then be rotated by given angle in radians"
	self multiplyBy: (self class rotation: anAngle)