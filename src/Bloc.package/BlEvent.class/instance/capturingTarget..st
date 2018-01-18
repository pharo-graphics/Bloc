private - steps
capturingTarget: aTBlEventTarget
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget.	
	self traversedTargets add: (BlEventTraversalCapturingStep new target: currentTarget)