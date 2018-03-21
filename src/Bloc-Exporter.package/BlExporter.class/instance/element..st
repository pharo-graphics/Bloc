api - configuration
element: aBlElement
	"Specify an element to be exorted"
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must not be nil' ].
	
	element := aBlElement