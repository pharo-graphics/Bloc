testing
isVisible
	self hostSpace ifNotNil: [ ^ self hostSpace isVisible ].
	^ false