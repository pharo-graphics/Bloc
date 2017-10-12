rotating
rotateByDegrees: anAngle axis: aPoint origin: anOrigin
	self addTransformation: (BlRotationTransformation new
		angle: anAngle;
		axis: aPoint asBlocVector;
		origin: anOrigin)