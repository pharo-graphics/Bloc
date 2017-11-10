accessing
maxScale: aNumber
	self
		assert: [ aNumber > 0 ]
		description: [ 'Scale factor must be greater than 0' ].

	maxScale := aNumber