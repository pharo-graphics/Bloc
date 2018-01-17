private - accessing
next: aBlEventDispatcherChain
	self
		assert: [ self hasNext not ]
		description: [ 'I am immutable' ].

	next := aBlEventDispatcherChain