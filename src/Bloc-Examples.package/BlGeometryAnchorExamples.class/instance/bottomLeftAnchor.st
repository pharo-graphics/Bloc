anchor - accessing
bottomLeftAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementBottomLeftAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 40@120.

	^ anAnchor