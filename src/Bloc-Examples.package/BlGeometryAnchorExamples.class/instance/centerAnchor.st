anchor - accessing
centerAnchor
	<gtExample>
	| anAnchor |

	anAnchor := BlElementCenterAnchor new.
	
	self
		assert: (anAnchor positionWithinBounds: (BlBounds origin: 40@20 extent: 200@100))
		equals: 140@70.
	
	^ anAnchor