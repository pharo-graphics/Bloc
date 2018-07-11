anchor - accessing
centerLeftAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementCenterLeftAnchor new.

	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 40@70.

	^ anAnchor