pulse managing
requestNextPulse
	"Request next universe pulse You may want to request next pulse if you develop bloc extention
	and rely on BlPulseEvent to execute some action on universe/space pulse.
	By the contract next pulse can be only requested if universe is running.
	It is done to not create pulse loop when it is actually not needed (for example during testing)"

	self
		assert: [ self pulseLoop isNotNil ]
		description: [ 'Pulse loop must not be nil' ].
	
	self
		assert: [ self pulseLoop isRunning ]
		description: [ 'Pulse loop must be running in order to request a pulse' ].

	nextPulseRequested := true