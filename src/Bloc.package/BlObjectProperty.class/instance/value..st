accessing
value: anObject
	self rawValue = anObject ifTrue: [ ^ self ].
	self invalidateDuring: [ 
		self rawValue: anObject.
		self notifyValueChanged ]