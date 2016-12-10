accessing
stackFromEnd: aBoolean

	self assertNotInLayoutOrScroll.
	
	stackFromEnd = aBoolean
		ifTrue: [ ^ self ].
	
	stackFromEnd := aBoolean.
	self requestLayout