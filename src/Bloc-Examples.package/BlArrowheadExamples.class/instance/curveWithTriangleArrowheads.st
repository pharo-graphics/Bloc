examples
curveWithTriangleArrowheads
	<gtExample>
	| container curve |
	
	container := BlParabollaExamples new relativeCurvatureWithoutDecorations.
	curve := container children first.
	
	curve fromHead: self triangleArrowhead.
	curve toHead: self triangleArrowhead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container