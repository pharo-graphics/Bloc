adding
addFloatFirst: aChild
	self
		assert: [ aChild isFloating ]
		description: [ 'I can only be used to add floating children!' ].

	children addFirst: aChild.
	
	length := length + aChild length + aChild spacingLength