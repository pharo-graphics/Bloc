accessing
value: anObject

	self invalidateDuring: [ 
			self rawValue: anObject.
			self notifyValueChanged ]