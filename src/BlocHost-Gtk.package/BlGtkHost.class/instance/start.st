api
start
	
	self
		assert: [ self isRunning not ]
		description: [ 'SDL host must not be running!' ].

	hostSpaces := Dictionary new. "(windowId -> BlGtkSpace)"
	eventHandler := BlSDLEventHandler new.
	Gtk primInit.
	self setupEventLoop.
	isRunning := true.
	
