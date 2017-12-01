example - connections
lineWithNearestCircleAnchors
	<gtExample>
	| redLine attachFrom attachTo |

	redLine := self redLine.

	attachFrom := self circleAttachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self circleAttachPoint.
	attachTo relocate: 400 @ 300.

	redLine fromAnchor: (BlNearestPositionCircleAnchor nearestTo: attachTo from: attachFrom).
	redLine toAnchor: (BlNearestPositionCircleAnchor nearestTo: attachFrom from: attachTo).

	^ self container
		addChildren: { redLine . attachFrom . attachTo }