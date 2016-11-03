adding
addFloatLast: aChild
	self
		assert: [ aChild isFloating ]
		description: [ 'I can only be used to add floating children!' ].

	children addLast: aChild.
	
	length := length + aChild length + aChild spacingLength