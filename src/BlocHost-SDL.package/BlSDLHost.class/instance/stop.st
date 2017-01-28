host - api
stop

	self
		assert: [ hostSpaces isNotNil and: [ hostSpaces isEmpty ] ]
		description: [ 'Can not stop SDL host with registered spaces!' ].
	
	self
		assert: [ self isRunning ]
		description: [ 'SDL host must be running in order to be stopped' ].

	self stopEventLoop.
	SDL2 quit.
	hostSpaces := nil.
	eventHandler := nil