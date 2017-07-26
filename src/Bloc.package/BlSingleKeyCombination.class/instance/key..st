accessing
key: aKey
	self
		assert: [ aKey isNotNil ]
		description: [ 'Key must not be nil' ].

	key := aKey