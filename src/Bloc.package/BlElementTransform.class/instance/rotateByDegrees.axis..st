transformations
rotateByDegrees: anAngle axis: aPoint
	self addTransformation: (BlRotationTransformation new
		angle: anAngle;
		axis: aPoint asBlocVector)