instance creation
simpleRoundedArrowArrowhead
	<gtExample>

	^ BlArrowheadSimpleArrow new
		arrowLengthFraction: 3;
		arrowNoseAngle: 60;
		border: (BlBorder builder joinRound paint: self curveColor; width: 20; build);
		background: self curveColor