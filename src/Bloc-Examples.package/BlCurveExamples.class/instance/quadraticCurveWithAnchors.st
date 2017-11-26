example - connections
quadraticCurveWithAnchors
	<gtExample>	
	| redCurve attachFrom attachTo viaAttach fromLine toLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 300.

	viaAttach := self attachPoint.
	viaAttach relocate: 250 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 400 @ 300.

	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: viaAttach).
	
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: viaAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).

	redCurve fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redCurve viaAnchor: (BlElementCenterAnchor element: viaAttach).
	redCurve toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { redCurve . attachFrom . viaAttach. attachTo . fromLine . toLine }