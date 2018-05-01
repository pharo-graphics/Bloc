examples - visual properties
blueArcWithToHead
	<gtExample>

	^ self blueArc
		toHead: (BlArrowheadSimpleArrow new
			arrowNoseAngle: 60;
			arrowLengthFraction: 5;
			border: (BlBorder paint: Color blue width: 2))