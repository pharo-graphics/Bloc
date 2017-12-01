examples
curveWithSimpleRoundedArrowArrowheads
	<gtExample>
	| container curve |
	
	container := BlParabollaExamples new relativeCurvatureWithoutDecorations.
	curve := container children first.
	
	curve fromHead: self simpleRoundedArrowArrowhead.
	curve toHead: self simpleRoundedArrowArrowhead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container