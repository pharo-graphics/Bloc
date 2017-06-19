host - api
start

	self
		assert: [ self isRunning not ]
		description: [ 'SDL host must not be running!' ].

	hostSpaces := Dictionary new. "(windowId -> BlSDLSpaceL)"
	eventHandler := BlSDLEventHandler new.
	self setupEventLoop.
	isRunning := true