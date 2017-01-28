host - api
start
	
	self
		assert: [ self isRunning not ]
		description: [ 'Gtk host must not be running!' ].

	hostSpaces := Dictionary new. "(windowId -> BlGtkSpace)"
	eventHandler := BlGtkEventHandler new.
	Gtk primInit.
	self setupEventLoop.
	isRunning := true.
	
	
