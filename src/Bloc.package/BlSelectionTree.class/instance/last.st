accessing
last
	self
		assert: [ self hasRoot ]
		description: [ 'There must be root!' ].
		
	^ self root findMax