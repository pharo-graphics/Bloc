anchor - geometry
curvaturePositions
	<return: #Collection of: #Point>

	self isSelfCurve
		ifTrue: [ ^ self fromAnchor selfPositionsWithin: self and: self toAnchor ].

	^ { self curvatureAnchor positionWithin: self }