geometry position
relocate: aPoint
	self position = aPoint
		ifTrue: [ ^ self ].
	self positionProperty value: aPoint.