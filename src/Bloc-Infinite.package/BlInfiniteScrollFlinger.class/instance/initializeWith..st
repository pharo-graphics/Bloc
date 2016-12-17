initialization
initializeWith: anInfiniteElement
	self
		assert: [ infiniteElement isNil ]
		description: [ 'I can be initialized only once!' ].
	
	infiniteElement := anInfiniteElement