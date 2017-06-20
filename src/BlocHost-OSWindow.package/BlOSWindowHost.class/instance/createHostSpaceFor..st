host - api
createHostSpaceFor: aSpace
	"Create and assign a new oswindow host space for given bloc space"
	| aHostSpace|
	
	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
		
	aHostSpace := self createWindowSpaceFor: aSpace.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace