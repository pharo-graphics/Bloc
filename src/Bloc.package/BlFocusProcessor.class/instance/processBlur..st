focus request
processBlur: anEvent
	lastFocusOwner ifNil: [ ^ self ].
	self fireAsFocusOutEvent: anEvent.
	self fireAsBlurEvent: anEvent.
	lastFocusOwner focused: false