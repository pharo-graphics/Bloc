example - connections
curveWithAnchors
	<gtExample>	
	| redCurve attachFrom attachTo firstViaAttach secondViaAttach fromLine toLine |
	
	redCurve := self redCurve.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 300.

	firstViaAttach := self attachPoint.
	firstViaAttach relocate: 150 @ 100.
	
	secondViaAttach := self attachPoint.
	secondViaAttach relocate: 350 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 400 @ 300.

	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: firstViaAttach).
	
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: secondViaAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).

	redCurve fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redCurve viaAnchor: (BlElementCenterAnchor element: firstViaAttach).
	redCurve viaAnchor: (BlElementCenterAnchor element: secondViaAttach).
	redCurve toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: { redCurve . attachFrom . firstViaAttach. secondViaAttach . attachTo . fromLine . toLine }