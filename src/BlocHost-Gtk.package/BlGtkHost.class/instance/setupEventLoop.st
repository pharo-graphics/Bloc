private - event loop
setupEventLoop
	"Create and start an loop for Gtk events"

	self
		assert: [ EventLoopProcess isNil ]
		description: [ 'Event loop must not exist!' ].
		
	EventLoopProcess := [ self eventLoopProcess ]
		forkAt: Processor lowIOPriority
		named: 'BlocHost SDL2 EventLoop'.
	