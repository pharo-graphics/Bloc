accessing
position: aPoint
	
	self position = aPoint ifTrue:[^ self].
	self invalidate.
	self positionProperty value: aPoint asIntegerPoint.
	self notifyPositionChanged.
	self changed.