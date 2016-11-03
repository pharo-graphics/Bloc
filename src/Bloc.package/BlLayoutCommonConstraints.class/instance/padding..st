accessing
padding: aBlPadding
	"Change element's margin to a BlMargin
	aBlPadding must not be nil"
	self
		assert: [ aBlPadding isNotNil ]
		description: [ 'Padding must not be nil' ].
	
	padding := aBlPadding