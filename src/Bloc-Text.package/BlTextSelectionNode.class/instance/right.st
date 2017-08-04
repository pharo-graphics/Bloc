accessing
right
	self
		assert: [ right isNotNil ]
		description: [ 'You can not access `right` if it does not exist. Check #hasRight first!' ].
	
	^ right