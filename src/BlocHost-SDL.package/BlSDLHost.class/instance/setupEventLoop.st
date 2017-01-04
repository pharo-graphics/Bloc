private - event loop
setupEventLoop
	"Create and start an loop for SDL2 events"
	
	self
		assert: [ EventLoopProcess isNil ]
		description: [ 'Event loop must not exist!' ].

	EventLoopProcess := (self class hasPlugin
		ifTrue: [ [ self eventLoopProcessWithPlugin ]  ]
		ifFalse: [ [ self eventLoopProcessWithoutPlugin ] ])
			forkAt: Processor lowIOPriority
			named: 'BlocHost SDL2 EventLoop'