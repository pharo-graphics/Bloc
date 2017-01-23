geometry position
relocate: aPoint
	
	self position = aPoint
		ifTrue: [ ^ self ].
	
	self position: aPoint.
	self requestParentLayout