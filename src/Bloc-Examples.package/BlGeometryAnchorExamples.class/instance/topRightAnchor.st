anchor - accessing
topRightAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementTopRightAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 240@20.

	^ anAnchor