accessing
depth: aNumber
	self
		assert: [ aNumber > 0 ]
		description: [ 'Perspective must be positive' ].

	depth := aNumber