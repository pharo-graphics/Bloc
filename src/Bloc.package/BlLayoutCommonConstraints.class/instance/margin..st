api - constraints
margin: aBlMargin
	"Change element's margin to a BlMargin
	aBlMargin must not be nil"
	self
		assert: [ aBlMargin isNotNil ]
		description: [ 'Margin must not be nil' ].
	
	margin := aBlMargin