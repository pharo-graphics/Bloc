examples - visual properties
redArcWithToHead
	<gtExample>

	^ self redArc
		toHead: (BlArrowheadSimpleArrow new
			arrowNoseAngle: 60;
			arrowLengthFraction: 5;
			border: (BlBorder paint: Color red width: 2))