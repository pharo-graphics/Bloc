initialization
initializeWith: aFactor

	self
		assert: [ factor isNil ]
		description: [ 'I am immutable - factor can only be set once!' ].
		
	factor := aFactor