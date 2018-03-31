initialization
initializeWith: anElement
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'An element must not be nil!' ].
	
	itemElement := anElement