accessing
duration: aDuration
	self
		assert: [ aDuration isNumber not ]
		description: [ 'Duration must not be a typeless number' ].

	isChanged := true.
	duration := aDuration