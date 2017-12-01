examples
curveWithSimpleArrowArrowheads
	<gtExample>
	| container curve |
	
	container := BlParabollaExamples new relativeCurvatureWithoutDecorations.
	curve := container children first.
	
	curve fromHead: self simpleArrowArrowhead.
	curve toHead: self simpleArrowArrowhead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container