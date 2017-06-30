instance creation
newLine
	<gtExample>

	^ BlLineElement new
		fromAnchor: (BlGeometryStaticAnchor position: 100 @ 100);
		toAnchor: (BlGeometryStaticAnchor position: 200 @ 200);
		border: (BlBorder paint: Color red width: 4);
		showAttachPoints;
		yourself