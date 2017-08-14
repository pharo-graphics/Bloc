accessing
first
	self
		assert: [ self hasRoot ]
		description: [ 'There must be root!' ].
		
	^ self root findMin