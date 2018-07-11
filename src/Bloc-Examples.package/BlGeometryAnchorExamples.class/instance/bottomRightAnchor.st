anchor - accessing
bottomRightAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementBottomRightAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 240@120.

	^ anAnchor