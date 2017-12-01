instance creation
simpleArrowArrowhead
	<gtExample>

	^ BlArrowheadSimpleArrow new
		arrowLengthFraction: 3;
		arrowNoseAngle: 45;
		border: (BlBorder builder paint: self curveColor; width: 15; build);
		background: self curveColor