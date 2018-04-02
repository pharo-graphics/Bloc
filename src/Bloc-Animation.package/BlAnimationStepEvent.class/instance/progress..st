accessing
progress: aNumber
	self
		assert: [ aNumber between: 0 and: 1 ]
		description: [ 'Progress must be within interval [0...1]' ].

	progress := aNumber