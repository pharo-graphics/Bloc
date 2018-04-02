api - configuration
loops: aNumber
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Amount of loops must not be negative' ].

	loop := aNumber