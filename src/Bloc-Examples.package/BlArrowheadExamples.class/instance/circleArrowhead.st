instance creation
circleArrowhead
	<gtExample>
	
	^ BlArrowheadCircle new
		background: self headColor;
		border: (BlBorder paint: self curveColor)