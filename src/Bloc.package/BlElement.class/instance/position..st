accessing
position: aPoint
	| delta |
	delta := (aPoint - self position) asPoint asIntegerPoint.
	delta isZero ifTrue: [ ^ self ].
	self invalidate.
	self transform translation: self position + delta asPoint.
	self notifyPositionChanged.
	self changed.