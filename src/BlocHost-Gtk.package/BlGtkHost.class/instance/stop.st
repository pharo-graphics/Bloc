host - api
stop
	
	self
		assert: [ hostSpaces isNotNil and: [ hostSpaces isEmpty ] ]
		description: [ 'Can not stop Gtk host with registered spaces!' ].
	
	self
		assert: [ self isRunning ]
		description: [ 'Gtk host must be running in order to be stopped' ].

	self stopEventLoop.
	Gtk primMainQuit.
	
	hostSpaces := nil.
	eventHandler := nil.
	isRunning := false.