instance creation
newLine
	<gtExample>

	^ BlLineElement new
		fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100);
		toAnchor: (BlAbsolutePositionAnchor position: 200 @ 200);
		border: (BlBorder paint: Color red width: 4);
		showAttachPoints;
		yourself