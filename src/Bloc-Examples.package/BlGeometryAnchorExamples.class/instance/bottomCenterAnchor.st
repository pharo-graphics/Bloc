anchor - accessing
bottomCenterAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementBottomCenterAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 140@120.

	^ anAnchor