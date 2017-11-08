window managing
showSpaceWindow: aSpace
	| shouldStartTheUniverse |
	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].

	shouldStartTheUniverse := self spaceManager hasSpaces not.

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
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host!' ].

	"We registered the first space, let's start the Universe"
	shouldStartTheUniverse
		ifTrue: [ self start ].