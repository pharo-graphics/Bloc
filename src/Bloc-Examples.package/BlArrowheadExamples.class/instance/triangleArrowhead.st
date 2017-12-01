instance creation
triangleArrowhead
	<gtExample>
	
	^ BlArrowheadTriangle new
		background: self headColor;
		border: (BlBorder paint: self curveColor width: 5)