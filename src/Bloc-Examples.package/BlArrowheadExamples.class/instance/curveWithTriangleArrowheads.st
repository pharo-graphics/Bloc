examples
curveWithTriangleArrowheads
	<gtExample>
	| container curve fromHead toHead |
	
	container := BlParabollaExamples new relativeCurvature.
	curve := container children first.
	
	fromHead := self triangleArrowhead.
	fromHead background: self headColor.
	fromHead border: (BlBorder paint: self curveColor width: 5).

	toHead := self triangleArrowhead.
	toHead background: self headColor.
	toHead border: (BlBorder paint: self curveColor width: 5).
	
	curve fromHead: fromHead.
	curve toHead: toHead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container