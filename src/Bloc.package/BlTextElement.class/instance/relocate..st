geometry position
relocate: aPoint
	self position = aPoint
		ifTrue: [ ^ self ].
	self positionProperty rawValue: aPoint.
	self positionProperty notifyValueChanged