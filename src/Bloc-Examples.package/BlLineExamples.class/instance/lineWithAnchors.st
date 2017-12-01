example - connections
lineWithAnchors
	<gtExample>	
	| redLine attachFrom attachTo |
	
	redLine := self redLine.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 400 @ 300.

	redLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redLine toAnchor: (BlElementCenterAnchor element: attachTo).


	^ self container
		addChildren: { redLine . attachFrom . attachTo }