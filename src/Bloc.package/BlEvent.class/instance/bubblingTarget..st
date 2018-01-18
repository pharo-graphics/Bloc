private - steps
bubblingTarget: aTBlEventTarget
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget.	
	self traversedTargets add: (BlEventTraversalBubblingStep new target: currentTarget)