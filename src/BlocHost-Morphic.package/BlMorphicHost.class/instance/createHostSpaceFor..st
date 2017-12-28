host - api
createHostSpaceFor: aSpace
	"Create and assign a new morphic host space for given bloc space"
	| aMorph aHostSpace|

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].

	aMorph := self createMorphFor: aSpace.
	aHostSpace := BlMorphicHostSpace new morph: aMorph.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace