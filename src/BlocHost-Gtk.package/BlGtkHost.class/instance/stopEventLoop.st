private - event loop
stopEventLoop
	"Terminate and destroy Gtk event loop"
	
	self
		assert: [ EventLoopProcess isNotNil ]
		description: [ 'Event loop must exist!' ].

	EventLoopProcess terminate.
	EventLoopProcess := nil.