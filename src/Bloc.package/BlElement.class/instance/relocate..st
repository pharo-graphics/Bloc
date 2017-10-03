geometry position
relocate: aPoint
	
	self measuredBounds position = aPoint
		ifTrue: [ ^ self ].
	
	self measuredBounds position: aPoint.
	self requestParentLayout