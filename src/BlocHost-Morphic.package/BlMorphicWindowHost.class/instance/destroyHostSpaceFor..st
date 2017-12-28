host - api
destroyHostSpaceFor: aSpace

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host!' ].
	
	aSpace hostSpace close.
	aSpace detachHostSpace