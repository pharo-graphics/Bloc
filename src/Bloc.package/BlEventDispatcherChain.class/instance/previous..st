private - accessing
previous: aBlEventDispatcherChain
	self
		assert: [ self hasPrevious not ]
		description: [ 'I am immutable' ].

	previous := aBlEventDispatcherChain