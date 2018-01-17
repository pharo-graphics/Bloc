accessing
code: aNumber

	self
		assert: [ code isNil ]
		description: [ 'Mouse button is immutable, create a new instance with the code' ].

	code := aNumber