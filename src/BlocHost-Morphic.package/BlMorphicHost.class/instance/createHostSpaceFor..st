host - api
createHostSpaceFor: aSpace
	"Create and assign a new morphic host space for given bloc space"
	| aWindow aHostSpace|

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].

	aWindow := self createMorphicWindowFor: aSpace.
	aHostSpace := BlMorphicHostSpace new morphicWindow: aWindow.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace