api - attaching / detaching
detach
	
	self isAttached
		ifFalse: [ ^ self ].
	
	referenceElement removeEventHandler: overlayListener.
	referenceElement := nil