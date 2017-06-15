window managing
closeSpaceWindow: aSpace

	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	self
		assert: [ aSpace hasHost ]
		description: [ 'Space must have a host!' ].

	"First destroy host space and "
	aSpace host destroyHostSpaceFor: aSpace.

	"then remove space itself from space manager"
	self spaceManager removeSpace: aSpace.

	(self spaceManager spaces anySatisfy: [ :eachSpace | eachSpace host == aSpace host ])
		ifFalse: [ aSpace host isRunning ifTrue: [ aSpace host stop ] ].

	"Stop universe if there are no spaces left"
	self spaceManager hasSpaces
		ifFalse: [ self stop ].

	self
		assert: [ aSpace hasHost not ]
		description: [ 'Host space must not have a host!' ]