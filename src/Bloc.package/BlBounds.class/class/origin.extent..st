instance creation
origin: anOrigin extent: anExtent

	self
		assert: [ anExtent x >= 0 and: [ anExtent y >= 0 ] ]
		description: [ 'Extent must be positive!' ].

	^ self new
		left: anOrigin x
		top: anOrigin y
		right: anOrigin x + anExtent x
		bottom: anOrigin y + anExtent y;
		yourself