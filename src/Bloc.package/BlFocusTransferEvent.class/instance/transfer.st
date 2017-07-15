accessing
transfer
	self
		assert: [ self hasTransfer ]
		description: [ 'Can not access transfer element when it does not exist' ].

	^ transfer