geometry position
resize: aPoint
	self extent = aPoint
		ifTrue: [ ^ self ].
	self extentProperty rawValue: aPoint.
	self extentProperty notifyValueChanged