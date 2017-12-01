example - connections
lineWithNearestBoundsAnchors
	<gtExample>
	| redLine attachFrom attachTo |

	redLine := self redLine.

	attachFrom := self rectangleAttachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self rectangleAttachPoint.
	attachTo relocate: 400 @ 300.

	redLine fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: attachTo from: attachFrom).
	redLine toAnchor: (BlNearestPositionBoundsAnchor nearestTo: attachFrom from: attachTo).

	^ self container
		addChildren: { redLine . attachFrom . attachTo }