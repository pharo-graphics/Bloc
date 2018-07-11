anchor - accessing
centerRightAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementCenterRightAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 240@70.

	^ anAnchor