accessing
color: aColor
	color := aColor.
	widget ifNil: [ ^ self ].
	self updateColor