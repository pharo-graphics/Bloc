rotating
rotateBy: aDegrees axis: aVectorPoint
	"Rotate about a given axis defined as a vector by a given amount of degrees"
	| rotation |
	
	rotation := BlQuaternion
		x: aVectorPoint x
		y: aVectorPoint y
		z: aVectorPoint z
		angle: aDegrees degreesToRadians.
	
	rotationQuaternion := rotation * rotationQuaternion