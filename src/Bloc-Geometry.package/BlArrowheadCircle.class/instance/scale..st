accessing
scale: aNumber
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Scale must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Scale must not be negative' ].
	
	scale := aNumber.
	self geometryChanged