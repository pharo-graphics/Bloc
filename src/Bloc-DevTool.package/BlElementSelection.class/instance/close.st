showing / hiding
close
	self
		assert: [ client isNotNil ]
		description: [ 'I must have a client element' ].

	self
		assert: [ self hasParent ]
		description: [ 'I must have parent' ].

	client removeEventHandler: clientListener.
	client := nil.
	self removeFromParent