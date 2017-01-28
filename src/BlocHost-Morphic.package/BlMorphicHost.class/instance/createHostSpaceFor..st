host - api
createHostSpaceFor: aSpace
	"Create and assign a new morphic host space for given bloc space"
	| aWindow aHostSpace|
	
	self
		assert: [ aSpace hasHost not ]
		description: [ 'Space must not have a host!' ].
		
	aWindow := self createMorphicWindowFor: aSpace.
	aHostSpace := BlMorphicSpace new morphicWindow: aWindow.

	aHostSpace withSpartaRenderer.
	aSpace hostSpace: aHostSpace