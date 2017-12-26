accessing
cornerRadius: aNumber
	cornerRadius := aNumber.
	
	widget ifNil: [ ^ self ].
	self updateCornerRadius.