accessing
opacity: aNumber
	self 
		assert: [ aNumber notNil ] 
		description: [ 'Opacity must be non-nil' ].
	self 
		assert: [ aNumber >= 0 and: [ aNumber <= 1 ] ] 
		description: [ 'Opacity must be the interval <0.0; 1.0>' ].
	opacity := aNumber