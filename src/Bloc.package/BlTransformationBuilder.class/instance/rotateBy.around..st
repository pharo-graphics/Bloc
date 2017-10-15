transformations
rotateBy: aDegreesAngle around: aVector
	transformation addTransformation: (BlRotationTransformation new angle: aDegreesAngle; axis: aVector; origin: origin)