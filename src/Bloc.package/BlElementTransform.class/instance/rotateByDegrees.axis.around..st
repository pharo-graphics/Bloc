transformations
rotateByDegrees: anAngle axis: aPoint around: anOrigin
	self addTransformation: (BlRotationTransformation new
		angle: anAngle;
		axis: aPoint asBlocVector;
		origin: anOrigin)