accessing
position: aPoint
	
	self position = aPoint ifTrue: [^ self].
	self invalidate.
	self positionProperty value: aPoint.
	self notifyPositionChanged.
	self changed.