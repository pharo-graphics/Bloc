event managing
dispatchEvent: anEvent
	self handlers ifEmpty: [ ^ self ].
	self handlers
		select: [ :h | h wantsEvent: anEvent ]
		thenDo: [ :h | h handleEvent: anEvent ]