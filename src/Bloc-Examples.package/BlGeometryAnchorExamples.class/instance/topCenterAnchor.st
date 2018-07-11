anchor - accessing
topCenterAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementTopCenterAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 140@20.

	^ anAnchor