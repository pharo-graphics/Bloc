heads - accessing
removeFromHead		
	self hasFromHead
		ifFalse: [ ^ self ].
		
	self removeChild: self fromHead.
	fromHead := nil