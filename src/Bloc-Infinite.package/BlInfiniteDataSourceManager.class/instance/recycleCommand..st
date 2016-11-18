commands recycling
recycleCommand: aCommand
	"Recycle aCommand removing any payload and if recycling enabled
	put in commands pool to allow manager to reuse objects for 
	performance reasons.
	I am also used by BlInfiniteDataSourceCommandsReorderer when it merges multiple commands in one
	aCommand must not be nil"
	self assert: aCommand isNotNil.

	shouldRecycle
		ifFalse: [ ^ self ].

	aCommand payload: nil.
	commandsPool release: aCommand