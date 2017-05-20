lifecycle
stop
	| currentProcess |
	
	self
		assert: [ loopProcess isNotNil ]
		description: [ 'Loop process must exist!' ].

	currentProcess := loopProcess.
	loopProcess := nil.
	currentProcess terminate