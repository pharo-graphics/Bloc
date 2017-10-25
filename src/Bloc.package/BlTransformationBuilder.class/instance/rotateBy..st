transformations
rotateBy: aDegreesAngle
	transformation addTransformation: (BlRotationTransformation new angle: aDegreesAngle; axis: BlVector zAxis; origin: origin)