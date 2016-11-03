testing
isVisible
	self hostWindow ifNotNil: [ ^ self hostWindow isVisible ].
	^ false