private
setupEventLoop
	EventLoopProcess ifNotNil: [ EventLoopProcess terminate ].
	EventLoopProcess := self class hasPlugin
		ifTrue: [ 
			[ self eventLoopProcessWithPlugin ] 
			forkAt: Processor lowIOPriority ]
		ifFalse: [ 
			[ self eventLoopProcessWithoutPlugin ] 
			forkAt: Processor lowIOPriority ].
	EventLoopProcess
		name: 'BlocHost SDL2 EventLoop';
		resume