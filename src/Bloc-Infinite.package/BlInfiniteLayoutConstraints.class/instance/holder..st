accessing
holder: anElementHolder
	"Change an element holder of the element I am attached to.
	anElement holder must not be nil"
	
	self
		assert: [ anElementHolder isNotNil ]
		description: [ 'An element holder must not be nil' ].

	holder := anElementHolder