examples
curveWithCircleArrowheads
	<gtExample>
	| container curve fromHead toHead |
	
	container := BlParabollaExamples new relativeCurvature.
	curve := container children first.
	
	fromHead := self circleArrowhead.
	fromHead background: self headColor.
	fromHead border: (BlBorder paint: self curveColor).

	toHead := self circleArrowhead.
	toHead background: self headColor.
	toHead border: (BlBorder paint: self curveColor).
	
	curve fromHead: fromHead.
	curve toHead: toHead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container