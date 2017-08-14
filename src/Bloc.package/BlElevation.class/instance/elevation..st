accessing
elevation: aNumber
	self
		assert: [ elevation isNil ]
		description: [ 'I am immutable and can not be changed' ].

	elevation := aNumber