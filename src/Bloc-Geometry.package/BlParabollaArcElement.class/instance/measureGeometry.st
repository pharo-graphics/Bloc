layout
measureGeometry
	| theAnchorPositions aDelta |
	
	theAnchorPositions := self decoratedAnchorPositions.
	aDelta := self layoutBounds origin.

	self geometry controlPoints: (theAnchorPositions collect: [ :aPoint | aPoint - aDelta ])