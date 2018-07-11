anchor - accessing
topLeftAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementTopLeftAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 40@20.

	^ anAnchor