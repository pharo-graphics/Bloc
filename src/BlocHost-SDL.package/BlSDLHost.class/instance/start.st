host - api
start

	self
		assert: [ self isRunning not ]
		description: [ 'SDL host must not be running!' ].

	hostSpaces := Dictionary new. "(windowId -> BlSDLSpaceL)"
	eventHandler := BlSDLEventHandler new.
	SDL2 initVideo.
	self setupEventLoop