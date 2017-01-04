private - event loop
stopEventLoop
	"Terminate and destroy SDL2 event loop"
	
	self
		assert: [ EventLoopProcess isNotNil ]
		description: [ 'Event loop must exist!' ].

	EventLoopProcess terminate.
	EventLoopProcess := nil.
	Smalltalk unregisterExternalObject: inputSemaphore