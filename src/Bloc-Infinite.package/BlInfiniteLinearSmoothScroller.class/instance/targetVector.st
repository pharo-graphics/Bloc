accessing
targetVector
	<return: #Point>
	
	self
		assert: [ targetVector isNotNil ]
		description: [ 'Target vector is unknown yet. Please, use #hasTargetVector in order to know if it is known' ].

	^ targetVector