accessing
visibility: aVisibility
	
	aVisibility = self visibility
		ifTrue: [ ^ self ].
	
	self visibilityProperty value: aVisibility.
	self invalidate