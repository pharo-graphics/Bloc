layout
measureGeometry	
	| theAnchorPositions aDelta |
	
	theAnchorPositions := self anchorPositions.
	aDelta := theAnchorPositions min.
	
	self geometry controlPoints: (self anchorPositions collect: [ :aPoint | aPoint - aDelta ])