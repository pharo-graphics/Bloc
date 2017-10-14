example - connections
twoLines
	<gtExample>
	
	| redLine blueLine attachPoint |
	
	redLine := self redLine.
	blueLine := self blueLine.
	
	attachPoint := self attachPoint.
	attachPoint relocate: 400 @ 200.

	redLine fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100).
	redLine toAnchor: (BlElementCenterAnchor element: attachPoint).
	
	blueLine fromAnchor: (BlElementCenterAnchor element: attachPoint).
	blueLine toAnchor: (BlAbsolutePositionAnchor position: 500 @ 500).

	^ self container
		addChildren: { redLine . blueLine . attachPoint }