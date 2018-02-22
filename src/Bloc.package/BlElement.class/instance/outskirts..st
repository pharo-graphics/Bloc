accessing
outskirts: aBlOutskirts
	"Change my outskirts - the way the border is interpreted.
	See BlOutskirts for more information"
	
	self
		assert: [ aBlOutskirts isNotNil ]
		description: [ 'Outskirts must not be nil' ].

	aBlOutskirts = self outskirts
		ifTrue: [ ^ self ].

	self invalidate.
	outskirts := aBlOutskirts.
	self invalidate