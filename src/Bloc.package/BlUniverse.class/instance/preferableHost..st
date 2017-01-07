accessing
preferableHost: aBlHost

	self
		assert: [ self isRunning not ]
		description: [ 'Universe must not be running!' ].

	self
		assert: [ preferableHost isNil or: [ preferableHost isRunning not ] ]
		description: [ 'Existing preferable host must not be running!' ].

	preferableHost := aBlHost