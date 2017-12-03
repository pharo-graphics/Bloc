instance creation
curveWithDifferentArrowheads
	<gtExample>

	| container curve |
	container := BlParabollaExamples new relativeCurvature.
	container := BlBezierExamples new curveWithAnchors.
	curve := container children first.
	curve fromHead: (BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			border: (BlBorder builder paint: (Color red alpha: 0.5); width: 10; build)).
	curve toHead: (BlArrowheadCircle new
		background: (Color red alpha: 0.2);
		border: (BlBorder paint: (Color red alpha: 0.5) width: 5)).
	curve border: (BlBorder paint: (Color red alpha: 0.5) width: 10).
	^ container