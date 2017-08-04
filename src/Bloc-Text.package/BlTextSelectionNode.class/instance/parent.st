accessing
parent
	self
		assert: [ parent isNotNil ]
		description: [ 'You can not access `parent` if it does not exist. Check #hasParent first!' ].
		
	^ parent