initialization
initializeAttachPoints

	attachPoints := self createAttachPoints.
	self addChildren: self attachPoints.
	self hideAttachPoints