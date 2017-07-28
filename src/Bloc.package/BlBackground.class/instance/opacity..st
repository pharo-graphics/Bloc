accessing
opacity: aNumber
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Opacity must not be nil' ].
	self
		assert: [ aNumber between: 0.0 and: 1.0 ]
		description: [ 'Opacity value must be within interval [0..1]' ].
	self
		assert: [ opacity isNil ]
		description: [ 'Opacity can not be changed once set. Background is immutable!' ].
	
	opacity := aNumber