host - api
destroyHostSpaceFor: aSpace

	self
		assert: [ aSpace hasHost ]
		description: [ 'Space must have a host!' ].
	
	aSpace hostSpace close.
	aSpace hostSpace: nil