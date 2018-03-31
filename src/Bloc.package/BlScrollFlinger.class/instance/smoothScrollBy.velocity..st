api - scrolling
smoothScrollBy: aDeltaPoint velocity: aVelocityPoint

	self
		smoothScrollBy: aDeltaPoint
		during: (self computeScrollDurationFor: aVelocityPoint distance: aDeltaPoint)