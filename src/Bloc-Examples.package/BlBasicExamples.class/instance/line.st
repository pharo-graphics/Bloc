examples - shape
line
	<gtExample>

	^ BlLineElement new
		fromAnchor: (BlAbsolutePositionAnchor position: 75 @ 140);
		toAnchor: (BlAbsolutePositionAnchor position: 200 @ 240);
		border: (BlBorder paint: Color red width: 4);
		yourself