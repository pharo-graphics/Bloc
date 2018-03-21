accessing
quality: aNumber
	
	self
		assert: [ aNumber between: 0 and: 100 ]
		description: [ 'Quality must be between 0 and 100' ].
	
	quality := aNumber