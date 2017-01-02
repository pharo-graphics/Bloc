geometry position
relocate: aPoint
	super relocate: aPoint
	"self position = aPoint
		ifTrue: [ ^ self ].
	self positionProperty value: aPoint.
	self notifyPositionChanged."