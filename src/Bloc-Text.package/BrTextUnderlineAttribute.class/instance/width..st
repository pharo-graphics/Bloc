accessing
width: aNumber
	self 
		assert: [ aNumber notNil ] 
		description: [ 'Width must be non-nil' ].
	self 
		assert: [ aNumber >= 0 ] 
		description: [ 'Width must be a pozitive number' ].
	width := aNumber