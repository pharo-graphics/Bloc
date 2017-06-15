window managing
showSpaceWindow: aSpace

	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	self
		assert: [ aSpace hasHost not ]
		description: [ 'Space must not have a host!' ].

	"We are going to register first space, let's start the Universe"
	self spaceManager hasSpaces
		ifFalse: [ self start ].

	"First of all we need to add space to the space manager"
	self spaceManager addSpace: aSpace.

	aSpace host
		ifNil: [ aSpace host: self host ].
	aSpace host isRunning
		ifFalse: [ aSpace host start ].

	"then create and show it in a host space"
	aSpace host createHostSpaceFor: aSpace.
	aSpace hostSpace show.

	self
		assert: [ aSpace hasHost ]
		description: [ 'Space must have a host!' ].