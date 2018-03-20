heads - accessing
removeToHead		
	self hasToHead
		ifFalse: [ ^ self ].
		
	self removeChild: self toHead.
	toHead := nil