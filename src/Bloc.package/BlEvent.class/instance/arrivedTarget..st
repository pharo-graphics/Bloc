private - steps
arrivedTarget: aTBlEventTarget
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget.	
	self traversedTargets add: (BlEventTraversalTargetStep new target: currentTarget)